// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import '../shared/ui_elements.dart';
import '../models/cardModel.dart';
import '../pages/imgInfo.dart';
import '../widgets/mapView.dart';

// CLASS: _FPHOMESTATE
class HomeTab extends StatelessWidget {
  // properties
  final bool isLoading;
  final List<CardModel> imgCards;
  final Function delCard;
  final Function fetchCards;
  final String loggedUserToken;
  final String loggedUserEmail;

  // constructor
  HomeTab({
    Key key,
    @required this.isLoading,
    @required this.imgCards,
    @required this.delCard,
    @required this.fetchCards,
    @required this.loggedUserToken,
    @required this.loggedUserEmail,
  }) : super(key: key);

  Widget _buildImgCards(BuildContext context, int index) {
    return Card(
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          Container( // header
            height: 35.0,
            padding: EdgeInsets.symmetric(horizontal: 7.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.person_pin, color: Theme.of(context).accentColor,),
                SizedBox(width: 2.5,),
                Expanded( // user
                  child: Text(imgCards[index].imgUser, textScaleFactor: 0.9,
                    style: TextStyle(color: Theme.of(context).accentColor),),
                ), // Expanded()
                IconButton( // location IconButton
                  icon: Icon(Icons.pin_drop, size: 17.5,),
                  color: Theme.of(context).accentColor,
                  onPressed: () { // show Map on button press
                    MapViewWidget().showMap(imgCard: imgCards[index]);
                  }, // show Map on button press
                ), // Location IconButton
              ], // children: <Widget>[]
            ), // Row
          ), // Container
          Container( // image
            height: MediaQuery.of(context).size.height/2, // almost half of screen height
            width: MediaQuery.of(context).size.width, // take full device width
            child: FadeInImage(
              image: NetworkImage(imgCards[index].imgUrl,),
              placeholder: AssetImage('assets/placeholder.jpg',),
              fit: BoxFit.cover
            ), // FadeInImage()
          ), // Container(): image
          Row( // Prediction + More Info Button
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded( // Prediction text
                child: Container(
                  child: Text('${imgCards[index].imgLabel}',
                    textScaleFactor: 1.1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),), // Text()
                  padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 10.0),
                  color: Theme.of(context).accentColor,
                ), // Container()
              ), // Expanded()
              Container( // Label confidence / accuracy
                child: Text('${((imgCards[index].imgAcc)*100).toStringAsFixed(2)}%',
                  textAlign: TextAlign.end,
                  style: TextStyle( // prediction accuracy, red if less than 70%
                    color: imgCards[index].imgAcc >= 0.7 ? Theme.of(context).accentColor : Colors.red,
                    fontStyle: FontStyle.italic,
                  ),), // Text()
                padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 10.0),
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).accentColor),),
              ), // Container()
              OutlineButton( // More info button
                padding: EdgeInsets.symmetric(vertical: 8.5, horizontal: 7.5),
                onPressed: () {
                  Navigator.push<bool>(context, MaterialPageRoute(
                    builder: (BuildContext context) => ImgInfo(
                      imgCard: imgCards[index],
                      loggedUserEmail: loggedUserEmail,
                    ), // builder: ImgInfo()
                  )) // Navigator.push: MaterialPageRoute()
                      .then((bool deleteBool) { // delete card on index if true
                    if(deleteBool) {delCard(imgCards[index]);}
                  }); // Navigator.then()
                }, // onPressed()
                child: Row( // More Info button
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('More Info'),
                    SizedBox(width: 2.5,),
                    Icon(Icons.info_outline, color: Theme.of(context).accentColor,),
                  ], // children: <Widget>[]
                ), // child: Row()
                borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.0),
              ), // OutlineButton()
            ], // children: <Widgets>[]
          ), // Row()
          //SizedBox(height: 5.0,),
          //Text(imgCards[index].imgDesc),
          //SizedBox(height: 5.0,),
          //MapViewWidget(imgCard: imgCards[index]),
        ], // children: <Widget>[]
      ), // child: Column()
    ); //return: Card()
  } // Widget: _buildImgCards

  Widget _buildImgList(BuildContext context) {
    Widget imgList;
    if(imgCards.length > 0) {
      imgList = ListView.builder(
        itemBuilder: _buildImgCards, // build Image Cards
        itemCount: imgCards.length, // Length of imgCards[] array
        //reverse: true,
      ); // imgList = ListView.builder()
    } else {
      imgList = Text('''No images found.
      Please add images!''',
        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      ); // ImgList = Text()
    } // else
    return imgList;
  } // Widget: _buildImgList()

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: appBackground,
      child: Center(
        child: RefreshIndicator(
          child: isLoading
              ? CircularProgressIndicator()
              : _buildImgList(context),
          onRefresh: fetchCards,
        ), // child: RefreshIndicator()
      ), // child: Center(),
    ); // return: Container()
  } // Widget: build()
} // class: HomeTab