// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import '../shared/globals.dart';
import '../shared/ui_elements.dart';
import '../models/cardModel.dart';
import '../models/locationModel.dart';
import '../widgets/mapLocation.dart';
import '../widgets/imgImport.dart';

// CLASS: CREATECARD
class CreateCard extends StatefulWidget {
  // properties
  final String loggedUserToken;
  final String loggedUserEmail;
  final Function addImg;

  // constructor
  CreateCard({
    @required this.loggedUserToken,
    @required this.loggedUserEmail,
    @required this.addImg,
  }); // CreateCard()

  State<StatefulWidget> createState() {
    return _CreateCardState();
  } // State: createState()
} // class: CreateCard

// CLASS: _CREATECARDSTATE
class _CreateCardState extends State<CreateCard> {
  //properties
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'imgDesc': '',
    'imgPath': null,
    'imgLabel': null,
    'location': null,
  }; // _formData
  LocationModel _locationModel;
  File _imgFile;
  List<dynamic> _prediction;

  Widget _imgDescTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Image Description',
          filled: true,
          fillColor: Colors.white,
      ), // Decoration for DescriptionTextField
      maxLines: 3,
      maxLength: 255,
      validator: (String value) {
        if (value.trim().length > 255) {
          return 'Maximum 255 characters';
        } // if statement
      }, // validator()
      onSaved: (String value) {
        _formData['imgDesc'] = value;
      }, // onSaved()
    ); // return: TextFormField()
  } // Widget: _imgDescTextField()

  void _setLocation(LocationModel locationModel) {
    _locationModel = locationModel;
    _formData['location'] = locationModel;
  } // setLocation()

  void _setImage(File imgFile) {
    _imgFile = imgFile;
    _formData['imgPath'] = imgFile;
  } // _setImage()

  void _setPrediction(Future<List<dynamic>> prediction) async {
    _prediction = await prediction;
    _formData['imgLabel'] = await prediction;
  } // _setPrediction()

  Future<Map<String, dynamic>> _storeImage(File image, {String imgPath}) async {
    final mimeType = lookupMimeType(image.path).split('/');
    final imgUploadReq = http.MultipartRequest(
      'POST', Uri.parse('$cloudfuncUrl/storeImage'));
    final imgFile = await http.MultipartFile.fromPath(
        'image', image.path,
        contentType: MediaType(mimeType[0],mimeType[1]),
    ); // imgFile
    imgUploadReq.files.add(imgFile);
    if(imgPath != null) {
      imgUploadReq.fields['imagePath'] = Uri.encodeComponent(imgPath);
    } // if-statement
    imgUploadReq.headers['Authorization'] = 'Bearer ${widget.loggedUserToken}';
    try {
      final streamedRes = await imgUploadReq.send();
      final response = await http.Response.fromStream(streamedRes);
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('Something went wrong!');
        print(json.decode(response.body));
        return null;
      } // if-check for imgUploadReq.send()
      final responseData = json.decode(response.body);
      return responseData;
    } catch(error) {
      print(error);
      return null;
    } // try.catch()
  } // _uploadImage

  Widget _floatingActionButton() {
    return FloatingActionButton(
      tooltip: 'Submit Image',
      elevation: 5.0,
      child: Icon(Icons.save),
      onPressed: isLoading ? null : () => _cardAddAction(),
    ); // return: FloatingActionButton()
  } // _floatingActionButton

  void _cardAddAction() async {
    setState(() {isLoading = true;}); // loading
    if(!_formKey.currentState.validate() || _imgFile == null || _locationModel.address.isEmpty) {
      setState(() {isLoading = false;});
      showDialog( // error dialog
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Missing Input', style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),),
              content: Text('Image and Location required!', textScaleFactor: 1.25,),
              actions: <Widget>[OutlineButton(
                child: Text('Okay', textScaleFactor: 1.25,),
                onPressed: () {Navigator.of(context).pop();},
              )], // actions: FlatButton()
            ); // AlertDialog()
          }); // showDialog()
      return; // exit action if not valid
    } // if check validation before submit
    _formKey.currentState.save();
    final DateTime nowUtc = DateTime.now().toUtc(); print(nowUtc.toIso8601String());
    final storeImgData = await _storeImage(_imgFile);
    if(storeImgData == null) {print('Upload failed!');}
    final Map<String, dynamic> _imgData = {
      'imgLabel': _prediction[0]['label'],
      'imgAcc': _prediction[0]['confidence'],
      'imgDesc': _formData['imgDesc'],
      'imgPath': storeImgData['imagePath'],
      'imgUrl': storeImgData['imageUrl'],
      'imgUser': widget.loggedUserEmail,
      'locAddress': _locationModel.address,
      'locLat': _locationModel.latitude,
      'locLng': _locationModel.longitude,
      'timeCreated': nowUtc.toIso8601String(),
      'timeUpdated': nowUtc.toIso8601String(),
    }; // imgData for JSON http.post
    http.post(
      '$firebaseUrl/imgCards.json?auth=${widget.loggedUserToken}',
      body: json.encode(_imgData),
    ).then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      widget.addImg(CardModel(
        imgId: responseData['name'],
        imgLabel: _prediction[0]['label'],
        imgAcc: _prediction[0]['confidence'],
        imgDesc: _formData['imgDesc'],
        imgPath: storeImgData['imagePath'],
        imgUrl: storeImgData['imageUrl'],
        imgUser: widget.loggedUserEmail,
        locAddress: _locationModel.address,
        locLat: _locationModel.latitude,
        locLng: _locationModel.longitude,
        timeCreated: nowUtc.toIso8601String(),
        timeUpdated: nowUtc.toIso8601String(),
      ),); // addImg()
    }); // http.post().then()
    await _statusUpdate(); // update status while saving
    Navigator.pop(context);
    setState(() {isLoading = false;}); // loading
  } // _cardAddButton()

  Future<void> _statusUpdate() async {
    final DateTime timeUtc = DateTime.now().toUtc();
    final int epochUtc = timeUtc.millisecondsSinceEpoch;
    final Map<String, dynamic> status = {
      'epoch_updated': epochUtc,
      'time_updated': timeUtc.toIso8601String(),
    }; // status
    final http.Response response = await http.put(
      '$firebaseUrl/status.json?auth=${widget.loggedUserToken}',
      body: json.encode(status),
    ); // http.post()
    final Map<String, dynamic> responseData = json.decode(response.body);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('epoch_updated', responseData['epoch_updated']);
    prefs.setString('time_updated', responseData['time_updated']);
  } // _statusUpdate()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle + ': Add Image'),
        actions: <Widget>[
          IconButton( // Submit Image
            icon: Icon(Icons.save),
            onPressed: isLoading ? null : () => _cardAddAction(),
          ), // IconButton: Submit Image
        ], // actions: <Widget>
      ), // AppBar
      body: Container(
        decoration: appBackground,
        child: Center(
          child: isLoading // Form
              ? CircularProgressIndicator()
              : Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  ImgImport(setImage: _setImage, setPrediction: _setPrediction),
                  SizedBox(height: 5.0,),
                  Container(
                    child: _imgDescTextField(),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                  ), // Container: DescriptionTextField
                  SizedBox(height: 5.0,),
                  MapLocation(setLocation: _setLocation),
                ], // children <Widget[]>
              ), // child: ListView()
          ), // child: Form
        ), // child: Center()
      ), // body: Container()
      floatingActionButton: _floatingActionButton(),
    ); // return: Scaffold()
  } // Widget: build()
} // class: _CreateCardState()
