// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/imgClassify.dart';
import 'dart:io';

// CLASS: IMGIMPORT
class ImgImport extends StatefulWidget {
  // properties
  final Function setImage;
  final Function setPrediction;

  // constructor
  ImgImport({@required this.setImage, @required this.setPrediction});

  @override
  State<StatefulWidget> createState() {
    return _ImgImportState();
  } // State: createState()
} // class: ImgImport

// CLASS _IMGIMPORTSTATE
class _ImgImportState extends State<ImgImport> {
  // properties
  bool isLoading = false;
  Future<List<dynamic>> _predictions;
  File _imgFile;

  void _getImage(BuildContext context, ImageSource source) {
    setState(() {isLoading = true;}); // loading
    ImagePicker.pickImage(
      source: source,
      maxHeight: 500,
      maxWidth: 500,
    ).then((File image) {
      setState(() {
        _predictions = ImgClassify(imgFile: image).predict(image);
        _imgFile = image;
      }); // setState()
      widget.setPrediction(_predictions);
      widget.setImage(_imgFile);
      Navigator.pop(context);
    }); // ImagePicker.pickImage().then()
    setState(() {isLoading = false;}); // loading
  } // _getImage

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10.0),
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton( // Camera
                  child: Column( // Camera
                    children: <Widget>[
                      Icon(Icons.camera_alt, size: 50.0, color: Theme.of(context).accentColor,),
                      Text('Camera', textScaleFactor: 1.25,),
                    ], // children: <Widget>[]
                  ), // child: Column
                  onPressed: () {_getImage(context, ImageSource.camera);},
                ), // FlatButton(): Camera
                FlatButton( // Gallery
                  child: Column( // Gallery
                    children: <Widget>[
                      Icon(Icons.photo_library, size: 50.0, color: Theme.of(context).accentColor,),
                      Text('Gallery', textScaleFactor: 1.25,),
                    ], // children: <Widget>[]
                  ), // child: Column()
                  onPressed: () {_getImage(context, ImageSource.gallery);},
                ), // FlatButton(): Gallery
              ], // children: <Widget>[]
            ), // Row()
          ); // Container()
        }); // builder()
  } //_showImagePicker

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        isLoading // getting image
            ? CircularProgressIndicator()
            : _imgFile != null
              ? Image.file(_imgFile) // display Image if exist
              : Container(), // else display empty Container
        Container( // Add/Change Image button
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: OutlineButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add_a_photo),
                SizedBox(width: 2.5,),
                Text(_imgFile == null ? 'Add Image' : 'Change Image'),
              ], // children: <Widget>[]
            ), // child: Row()
            borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.5),
            onPressed: () {
              _showImagePicker(context);
            }, // onPressed
          ), // OutlineButton
        ), // Container: Add Image Button
      ], // children: <Widget>[]
    ); // return: Column()
  } // Widget: build()
} // class: _ImgImportState