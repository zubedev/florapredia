// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import '../shared/ui_elements.dart';
import '../models/cardModel.dart';
import '../pages/imgInfo.dart';
import '../widgets/mapView.dart';

// CLASS: USERTAB
class UserTab extends StatelessWidget {
  // properties
  final bool isLoading;
  final List<CardModel> imgCards;
  final Function delCard;
  final String loggedUserToken;
  final String loggedUserEmail;

  // constructor
  UserTab({
    @required this.isLoading,
    @required this.imgCards,
    @required this.delCard,
    @required this.loggedUserToken,
    @required this.loggedUserEmail,
  }); // UserTab()

  @override
  Widget build(BuildContext context) {
    // properties
    final List<CardModel> _userImgCards = imgCards.where((card) => card.imgUser == loggedUserEmail).toList();

    return Container(
      decoration: appBackground,
      child: isLoading
          ? Container(child: Center(child: CircularProgressIndicator(),),)
          : CustomScrollView(
        slivers: <Widget>[
          SliverList( // user info
            delegate: SliverChildListDelegate([
             Card( // user info
               elevation: 5.0,
               child: Container(
                 padding: EdgeInsets.all(10.0),
                 child: Row( // user info row
                   children: <Widget>[
                     Container(child: Icon(Icons.person, size: 50,), padding: EdgeInsets.all(7.5), decoration: BoxDecoration(border: Border.all(color: Theme.of(context).accentColor, width: 2.0)),),
                     SizedBox(width: 10.0,), // spacing between icon and info
                     Expanded( // user info
                       child: Column( // user info column
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Text(loggedUserEmail, style: TextStyle(fontWeight: FontWeight.bold),),
                           SizedBox(height: 5.0,), // spacing between user and # posts
                           Text('Total posts # ${_userImgCards.length.toString()}', style: TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).accentColor),),
                         ], // children: <Widget>[]
                       ), // Column(): user info
                     ), // Expanded(): user info
                     Container(child: IconButton( // location icon
                         icon: Icon(Icons.person_pin_circle, color: Theme.of(context).accentColor,),
                         onPressed: () => MapViewWidget().showMap(imgCards: _userImgCards,),
                     )), // Container(): IconButton(): location icon
                   ], // children: <Widget>[]
                 ), // Row()
               ), // Container()
             ), // Card(): user info
            ]), // delegate: SliverChildListDelegate()
          ), // SliverList(): user info
          SliverGrid( // user only cards
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2.5,
                crossAxisSpacing: 2.5,
            ), // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount()
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return GestureDetector(
                child: FadeInImage( // image stack layer
                  image: NetworkImage(_userImgCards[index].imgUrl,),
                  placeholder: AssetImage('assets/placeholder.jpg',),
                  fit: BoxFit.cover,
                ), // FadeInImage(): image stack layer
                onTap: () { // navigate to ImgInfo page
                  Navigator.push<bool>(context, MaterialPageRoute(
                    builder: (BuildContext context) => ImgInfo(
                        imgCard: _userImgCards[index],
                        loggedUserEmail: loggedUserEmail,
                    ), // builder(): ImgInfo()
                  )) // Navigator.push<bool>
                  .then((bool deleteBool) { // delete card on index if true
                    if(deleteBool) {delCard(_userImgCards[index]);}
                  }); // Navigator.push<bool>.then()
                }, // onTap: navigate to ImgInfo page
              ); // return: GestureDetector()
            }, // builder()
                childCount: _userImgCards.length,
            ), // delegate: SliverChildBuilderDelegate()
          ), // SliverGrid(): user only cards
        ], // slivers: <Widget>[]
      ), // child: CustomScrollView()
    ); // return: Container()
  } // Widget: build()
} // class: UserTab