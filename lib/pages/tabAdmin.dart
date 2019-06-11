// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../shared/globals.dart';
import '../shared/ui_elements.dart';
import '../shared/db_helper.dart';
import '../models/cardModel.dart';
import '../tabs/homeTab.dart';
import '../tabs/mapTab.dart';
import '../tabs/userTab.dart';
import '../widgets/mapView.dart';
import 'auth.dart';
import 'createCard.dart';

// CLASS: TABADMIN
class TabAdmin extends StatefulWidget {
  // properties
  final String loggedUserToken;
  final String loggedUserEmail;

  // constructor
  TabAdmin({
    Key key,
    @required this.loggedUserToken,
    @required this.loggedUserEmail,
  }) : super(key: key); // TabAdmin()

  @override
  State<StatefulWidget> createState() {
    return _TabAdminState();
  } // State<> createState()
} // class: TabAdmin

// CLASS: _TABADMINSTATE
class _TabAdminState extends State<TabAdmin> with SingleTickerProviderStateMixin {
  // properties
  bool isLoading = false;
  List<CardModel> _imgCards = [];
  TabController _tabCtrl;
  DbHelper _db = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(
        length: 3,
        vsync: this,
        initialIndex: 0,
    )..addListener(() {
      setState(() {});
    }); // _tabCtrl
    _fetchCards();
  } // initState()

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  } // dispose()

  Future<bool> _statusCheck() async { // return true for updates exists
    final http.Response response = await http.get('$firebaseUrl/status.json?auth=${widget.loggedUserToken}');
    final Map<String, dynamic> responseData = json.decode(response.body);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int localEpochUpdated = prefs.getInt('epoch_updated') != null ? prefs.getInt('epoch_updated') : 0;
    if(responseData['epoch_updated'] > localEpochUpdated) {
      prefs.setInt('epoch_updated', responseData['epoch_updated']);
      prefs.setString('time_updated', responseData['time_updated']);
      return true; // return true for updates exists
    } else {return false;}// if-check: updates exists
  } // _statusCheck()

  Future<void> _fetchCards() async {
    setState(() {isLoading = true;}); // loading
    final bool updatesExists = await _statusCheck();
    if(updatesExists == false) { // no update exists
      _imgCards = []; // clear the list
      final List<Map<String, dynamic>> dbCards = await _db.getCards();
      for(int i = 0; i < dbCards.length; i++) {
        final CardModel card = CardModel(
            imgId: dbCards[i]['_id'],
            imgLabel: dbCards[i]['label'],
            imgAcc: dbCards[i]['accuracy'],
            imgDesc: dbCards[i]['description'],
            imgPath: dbCards[i]['path'],
            imgUrl: dbCards[i]['url'],
            imgUser: dbCards[i]['user'],
            locAddress: dbCards[i]['address'],
            locLat: dbCards[i]['latitude'],
            locLng: dbCards[i]['longitude'],
            timeCreated: dbCards[i]['created'],
            timeUpdated: dbCards[i]['updated'],
        ); // card
        await _addCard(card);
      } // for-loop
      setState(() {isLoading = false;}); // finished loading
    } else { // if update exists
      _imgCards = []; // clear the list
      final http.Response response = await http.get(
          '$firebaseUrl/imgCards.json?auth=${widget.loggedUserToken}'
      ); // http.get()
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData == null) { // check if responseData = null
        setState(() {isLoading = false;}); // not loading
        return; // return to HomeTab if no data to fetch
      } // if (responseData == null)
      responseData.forEach((String fetchedId, dynamic fetchedData) async {
        final CardModel fetchedCard = CardModel(
          imgId: fetchedId,
          imgLabel: fetchedData['imgLabel'],
          imgAcc: fetchedData['imgAcc'],
          imgDesc: fetchedData['imgDesc'],
          imgPath: fetchedData['imgPath'],
          imgUrl: fetchedData['imgUrl'],
          imgUser: fetchedData['imgUser'],
          locAddress: fetchedData['locAddress'],
          locLat: fetchedData['locLat'],
          locLng: fetchedData['locLng'],
          timeCreated: fetchedData['timeCreated'],
          timeUpdated: fetchedData['timeUpdated'],
        ); // CardModel fetchedCard
        await _addCard(fetchedCard);
      }); // responseData.forEach()
      setState(() {isLoading = false;}); // finished loading
    } // if-check: update exists or not
  } // _fetchCards

  Widget _floatingActionButton() {
    Widget button;
    if(_tabCtrl.index == 0) { // home tab
      button = FloatingActionButton(
        tooltip: 'Add Image',
        elevation: 5.0,
        child: Icon(Icons.add_a_photo),
        onPressed: () { // navigate to CreateCard page
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => CreateCard(
              loggedUserToken: widget.loggedUserToken,
              loggedUserEmail: widget.loggedUserEmail,
              addImg: _addCard,
            ), // builder: CreateCard()
          )); // Navigator.push: MaterialPageRoute()
        }, // onPressed()
      ); // button: FloatingActionButton(): home tab
    } else if(_tabCtrl.index == 1) { // map tab
      button = FloatingActionButton(
          tooltip: 'All Images Map',
          elevation: 5.0,
          child: Icon(Icons.map),
          onPressed: _imgCards.length > 0 ? () => MapViewWidget().showMap(imgCards: _imgCards) : null,
      ); // button: FloatingActionButton(): map tab
    } else if(_tabCtrl.index == 2) { // map tab
      button = FloatingActionButton(
        tooltip: 'User Posts Map',
        elevation: 5.0,
        child: Icon(Icons.person_pin_circle),
        onPressed: () => MapViewWidget().showMap(imgCards: _imgCards.where((card) => card.imgUser == widget.loggedUserEmail).toList()),
      ); // button: FloatingActionButton(): map tab
    } // if-check for TabController index
    return button; // return button depending on TabController index
  } // _floatingActionButton()

  // Add Image method
  Future<void> _addCard(CardModel imgCard) async {
    final List<CardModel> sortedList = [];
    sortedList.add(imgCard);
    if(await _db.getCard(imgCard.imgId) == null) {
      await _db.insert(imgCard);
    } // if-check exists in db
    if (_imgCards.length > 0) {
      _imgCards.forEach((CardModel card) {
        sortedList.add(card);
      }); // sort the list
    } // check list for empty then sort
    setState(() {
      _imgCards = sortedList;
    }); // setState()
  } // _addCard()

  // Delete Image method
  Future<void> _delCard(CardModel imgCard) async {
    await _db.delete(imgCard.imgId);
    await http.delete(
        '$firebaseUrl/imgCards/${imgCard.imgId}.json?auth=${widget.loggedUserToken}'
    ).then((http.Response response) {
      _imgCards.removeAt(_imgCards.indexOf(imgCard));
      _fetchCards();
    }); // http.delete().then()
  } // _delImg()

  Future<void> _logout() async {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to logout?'),
            //content: Text('Please confirm'),
            actions: <Widget>[
              FlatButton(
                child: Text('No, Dismiss', style: TextStyle(color: Colors.white),),
                color: Colors.blueGrey,
                onPressed: () {
                  Navigator.pop(context); // closes dialog box without action.
                }, // onPressed: go back!
              ), // FlatButton: No, Dismiss!
              FlatButton(
                child: Text('Yes, Logout!', style: TextStyle(color: Colors.white),),
                color: Colors.red,
                onPressed: () async {
                  setState(() {isLoading = true;});
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('idToken'); // Remove User ID Token from Device
                  prefs.remove('email'); // Remove User Email from Device
                  prefs.remove('localId'); // Remove User Local ID from Device
                  prefs.remove('expiresIn'); // Remove User Token Expiry Time from Device
                  Navigator.pop(context); // closes dialog box, continue to navigate
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AuthPage(),));
                  setState(() {isLoading = false;});
                }, // onPressed: delete!
              ), // FlatButton: Yes, Delete!
            ], // actions: <Widget>[]
          ); // AlertDialog()
        }); // showDialog()
  } // _logout()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        //leading: Icon(Icons.local_florist),
        bottom: TabBar(
          controller: _tabCtrl,
          tabs: [
            Tab(icon: Icon(Icons.home),), // home tab
            Tab(icon: Icon(Icons.map),), // map tab
            Tab(icon: Icon(Icons.person),), // user tab
          ], // tabs: []
        ), // bottom: TabBar()
        actions: <Widget>[
          IconButton( // Refresh Home Screen
            icon: Icon(Icons.refresh),
            onPressed: isLoading ? null : () => _fetchCards(),
          ), // IconButton: Refresh Home Screen
          IconButton( // Logout to Auth Page
            icon: Icon(Icons.exit_to_app),
            onPressed: isLoading ? null : () => _logout(),
          ), // IconButton: Refresh Home Screen
        ], // actions: <Widget>
      ), // appBar: AppBar()
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          HomeTab( // 1st Tab: home tab
            isLoading: isLoading,
            imgCards: _imgCards,
            delCard: _delCard,
            fetchCards: _fetchCards,
            loggedUserToken: widget.loggedUserToken,
            loggedUserEmail: widget.loggedUserEmail,
          ), // HomeTab(): 1st Tab: home tab
          MapTab(
            imgCards: _imgCards,
          ), // 2nd Tab: map tab
          UserTab( // 3rd Tab: user tab
            isLoading: isLoading,
            imgCards: _imgCards,
            delCard: _delCard,
            loggedUserToken: widget.loggedUserToken,
            loggedUserEmail: widget.loggedUserEmail,
          ), // UserTab(): 3rd Tab: user tab
        ], // children[]
      ), // body: TabBarView()
      floatingActionButton: _floatingActionButton(),
    ); // child: Scaffold()
  } // Widget: build()
} // class: TabAdmin