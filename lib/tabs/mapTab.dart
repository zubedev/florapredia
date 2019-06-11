// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import '../shared/ui_elements.dart';
import '../shared/globals.dart';
import '../models/cardModel.dart';
import '../widgets/mapView.dart';

// CLASS: MAPTAB
class MapTab extends StatelessWidget {
  // properties
  final List<String> _avatars = [];
  final List<CardModel> imgCards;

  // constructor
  MapTab({
    @required this.imgCards,
  }); // MapTab()
  
  void _genAvatars() { // generates avatars from assets samples
    for(int i = 0; i < floraClasses.length; i++) { // generate avatars
      _avatars.add('assets/samples/${floraClasses[i]} 0.jpg');
    } // for-loop
  } // _genAvatars()

  List<CardModel> _getCustomList({List<CardModel> cards, String label}) {
    final List<CardModel> customList = cards.where((card) => card.imgLabel == label).toList();
    return customList;
  } // _getCustomList

  void _showMap(List<CardModel> cards, String label, BuildContext context) {
    if(cards.length > 0) { // cards length
      MapViewWidget().showMap(imgCards: cards);
    } else { // error dialog
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No map found'),
              content: Text('No images of $label were found. Map could not be generated'),
              actions: <Widget>[
                FlatButton( // Okay
                  child: Text('Okay', style: TextStyle(color: Colors.white),),
                  color: Theme.of(context).accentColor,
                  onPressed: () { // dismiss the dialog box on pressed
                    Navigator.pop(context); // navigate away from the dialog box
                  }, // onPressed: go back!
                ), // FlatButton(): Okay
              ], // actions: <Widget>[]
            ); // return: AlertDialog()
          }); // showDialog
    } // if-check cards length, else show error dialog
  } // _showMap
  
  @override
  Widget build(BuildContext context) {
    _genAvatars(); // generates avatars from assets samples
    return Container(
      decoration: appBackground,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList( // header
            delegate: SliverChildListDelegate([
              Card( // map info
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row( // map info row
                    children: <Widget>[
                      Container(child: Icon(Icons.map, size: 50,), padding: EdgeInsets.all(7.5), decoration: BoxDecoration(border: Border.all(color: Theme.of(context).accentColor, width: 2.0)),),
                      SizedBox(width: 10.0,), // spacing between icon and info
                      Expanded( // map info
                        child: Column( // map info column
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Map View', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5.0,), // spacing between user and # posts
                            Text('Tap below to show class only map', style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).accentColor),),
                          ], // children: <Widget>[]
                        ), // Column(): map info
                      ), // Expanded(): map info
                      Container(child: IconButton( // all location icon
                        icon: Icon(Icons.all_inclusive, color: Theme.of(context).accentColor,),
                        onPressed: () => _showMap(imgCards, 'any classes', context),
                      )), // Container(): IconButton(): all location icon
                    ], // children: <Widget>[]
                  ), // Row()
                ), // Container()
              ), // Card(): user info
            ]), // delegate: SliverChildListDelegate([])
          ), // SliverList(): //header
          SliverList( // list tile
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return Card( // list tile
                child: ListTile( // floraClasses
                  title: Text(floraClasses[index]),
                  leading: CircleAvatar(backgroundImage: AssetImage(_avatars[index])),
                  trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).accentColor,),
                  onTap: () => _showMap(_getCustomList(cards: imgCards, label: floraClasses[index]), floraClasses[index], context),
                ), // ListTile()
              ); // return: Card()
            }, // builder()
                childCount: floraClasses.length
            ), // delegate: SliverChildBuilderDelegate(() {
          ), // SliverList(): list tile
        ], // slivers: <Widget>[]
      ), // child: CustomScrollView()
    ); // return: Container()
  } // Widget: build()
} // class: _MapTabState