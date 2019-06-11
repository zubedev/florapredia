// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'dart:async';
import '../shared/globals.dart';
import '../shared/ui_elements.dart';
import '../models/cardModel.dart';
import '../widgets/mapView.dart';
import '../widgets/infoWidget.dart';

// CLASS: IMGINFO
class ImgInfo extends StatelessWidget {
  // properties
  final CardModel imgCard;
  final String loggedUserEmail;

  // constructor
  ImgInfo({
    @required this.imgCard,
    @required this.loggedUserEmail,
  }); // ImgInfo()

  // Delete Dialog method
  _showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This action cannot be undone!'),
            actions: <Widget>[
              FlatButton(
                child: Text('No, Dismiss', style: TextStyle(color: Colors.white),),
                color: Colors.blueGrey,
                onPressed: () {
                  Navigator.pop(context); // closes dialog box without action.
                }, // onPressed: go back!
              ), // FlatButton: No, Dismiss!
              FlatButton(
                child: Text('Yes, Delete!', style: TextStyle(color: Colors.white),),
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context); // closes the dialog box...
                  Navigator.pop(context, true); // set true for delete
                }, // onPressed: delete!
              ), // FlatButton: Yes, Delete!
            ], // actions: <Widget>[]
          ); // return AlertDialog()
        }); // showDialog: builder()
  } // Widget: _showDeleteDialog()

  List<String> _samplesList(String imgLabel) {
    final List<String> _samples = [];
    for(int i = 0; i < 9; i++) {
      _samples.add('assets/samples/$imgLabel $i.jpg');
    } // for-loop
    return _samples;
  } // _samplesList()

  @override
  Widget build(BuildContext context) {
    // properties
    List<String> samplesList = []; // samples

    // return a samplesList based on image label
    samplesList = _samplesList(imgCard.imgLabel);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false); // set to false for no delete image!
        return Future.value(false); // import dart:async for Future.
      }, // onWillPop:
      child: Scaffold(
        appBar: AppBar(
          title: Text(appTitle + ': Image info'),
          actions: <Widget>[
            IconButton( // Delete Image
              icon: Icon(Icons.delete_forever),
              onPressed: loggedUserEmail == imgCard.imgUser || loggedUserEmail == devEmail
                  ? () =>  _showDeleteDialog(context)
                  : null, // disable delete button
            ), // IconButton: Delete Image
          ], // actions: <Widget>
        ), // AppBar()
        body: Container(
          decoration: appBackground,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList( // info
                delegate: SliverChildListDelegate([
                  Card(
                    elevation: 5.0,
                    child: Column(
                      children: <Widget>[
                        Container( // image
                          height: MediaQuery.of(context).size.height/2, // almost half of screen height
                          width: MediaQuery.of(context).size.width, // take full device width
                          child: FadeInImage(
                              image: NetworkImage(imgCard.imgUrl,),
                              placeholder: AssetImage('assets/placeholder.jpg',),
                              fit: BoxFit.cover
                          ), // FadeInImage()
                        ), // Container(): image
                        Row( // Prediction + More Info Button
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded( // Prediction text
                              child: Container(
                                child: Text('${imgCard.imgLabel}',
                                  textScaleFactor: 1.1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),), // Text()
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                color: Theme.of(context).accentColor,
                              ), // Container()
                            ), // Expanded()
                            Container( // Label confidence / accuracy
                              child: Text('${((imgCard.imgAcc)*100).toStringAsFixed(2)}%',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),), // Text()
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              decoration: BoxDecoration(border: Border.all(color: Theme.of(context).accentColor),),
                            ), // Container()
                            FlatButton( // Delete button passes back true boolean value
                              onPressed: loggedUserEmail == imgCard.imgUser || loggedUserEmail == devEmail
                                  ? () => _showDeleteDialog(context)
                                  : null, // disable delete button
                              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Delete'),
                                  Icon(Icons.delete_forever),
                                ], // children: <Widget>[]
                              ), // child: Row()
                              color: Colors.red,
                            ), // FlatButton()
                          ], // children: <Widgets>[]
                        ), // Row()
                        Container( // header
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.person_pin, color: Theme.of(context).accentColor,),
                              SizedBox(width: 2.5,),
                              Expanded(
                                child: Text(imgCard.imgUser, style: TextStyle(color: Theme.of(context).accentColor),),
                              ), // Expanded()
                              IconButton( // location IconButton
                                icon: Icon(Icons.pin_drop),
                                color: Theme.of(context).accentColor,
                                onPressed: () { // show Map on button press
                                  MapViewWidget().showMap(imgCard: imgCard);
                                }, // show Map on button press
                              ), // Location IconButton
                            ], // children: <Widget>[]
                          ), // Row
                        ), // Container
                        Container( // image description
                          child: Text(imgCard.imgDesc,),
                          alignment: AlignmentDirectional.topStart,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                        ), // Container: image description
                        //MapViewWidget(imgCard: imgCard),
                        InfoWidget(floraClass: imgCard.imgLabel), // get info Card on floraClass
                        SizedBox(height: 5.0,),
                      ], // children: <Widget>[]
                    ), // child: Column()
                  ), //return: Card()
                ]), // delegate: info
              ), // SliverList()
              SliverGrid( // samples
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2.5,
                    crossAxisSpacing: 2.5,
                ), // SliverGridDelegateWithFixedCrossAxisCount()
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return Image.asset(samplesList[index]);
                }, // SliverChildBuilderDelegate()
                childCount: samplesList.length,
                ), // delegate: samples
              ), // SliverGrid()
            ], // slivers: <Widget>[]
          ), // CustomScrollView()
        ), //body: Container()
      ), // return: Scaffold()
    ); // return: WillPopScope()
  } // Widget: build()
} // class: ImgInfo