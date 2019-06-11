// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../shared/globals.dart';
import '../shared/ui_elements.dart';
import '../models/userModel.dart';
import 'tabAdmin.dart';

// ENUM: for switching authentication modes
enum AuthMode {Login, Signup}

// CLASS: AUTHPAGE
class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  } // State: createState()
} // class: AuthPage()

// CLASS: _AUTHPAGESTATE
class _AuthPageState extends State<AuthPage> {
  // properties
  bool isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final List<UserModel> _users = [];
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'returnSecureToken': true, // needed for FireBase Authentication
  }; // _formData
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _autoLogin(); // if user shared preferences exists
  } // initState()

  Future<void> _autoLogin() async { // if user shared preferences exists
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('idToken') != null) {
      final DateTime expiresIn = DateTime.parse(prefs.getString('expiresIn'));
      if(expiresIn.isAfter(DateTime.now())) {
        setState(() {isLoading = true;});
        _users.add(UserModel( // add to UserModel on signup/login success
          idToken: prefs.getString('idToken'),
          email: prefs.getString('email'),
          localId: prefs.getString('localId'),
          expiresIn: expiresIn,
        )); // add user to List<UserModel> _users
        _navToHome( // navigate to FPHome
          token: prefs.getString('idToken'),
          email: prefs.getString('email'),
        ); // _navToHome
        setState(() {isLoading = false;});
      } else { // if-check: token expiry time
        setState(() { // Remove login information from device on expiry
          prefs.remove('idToken'); // Remove User ID Token from Device
          prefs.remove('email'); // Remove User Email from Device
          prefs.remove('localId'); // Remove User Local ID from Device
          prefs.remove('expiresIn'); // Remove User Token Expiry Time from Device
        }); // setState()
      } // if-check: token expiry time
    } // if-check
  } // _autoLogin()

  void _navToHome({String token, String email}) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (BuildContext context) => TabAdmin(
        loggedUserToken: token,
        loggedUserEmail: email,
      ), //builder: TabAdmin()
    )); // Navigator: pushReplacement()
  } // navToHome

  Widget _emailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Email Address',
          filled: true,
          fillColor: Colors.white,
      ), // decoration: InputDecoration()
      validator: (String value) {
        if (value.isEmpty || !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
          return 'Please enter valid email address';
        } // if statement
      }, // validator
      onSaved: (String value) {
        _formData['email'] = value;
      }, // onSaved()
    ); // return: TextFormField
  } // Widget: _emailTextField()

  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordTextController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white,
      ), // decoration: InputDecoration()
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Please enter valid password';
        } // if statement
      }, // validator
      onSaved: (String value) {
        _formData['password'] = value;
      }, // onSaved()
    ); // return: TextFormField
  } // Widget: _emailTextField()

  Widget _passwordConfirmTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        filled: true,
        fillColor: Colors.white,
      ), // decoration: InputDecoration()
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Passwords do not match';
        } // if statement
      }, // validator
    ); // return: TextFormField
  } // Widget: _emailTextField()

  Future<Null> _signupLoginAction() async {
    setState(() {isLoading = true;}); // loading
    if (!_formKey.currentState.validate()) {
      setState(() {isLoading = false;});
      return; // don't progress if form fields invalid!
    } // if statement
    _formKey.currentState.save();
    final http.Response response = await http.post(_authMode == AuthMode.Signup
      ? '$authApiUrl/signupNewUser?key=$authApiKey'
      : '$authApiUrl/verifyPassword?key=$authApiKey',
      body: json.encode(_formData),
      headers: {'Content-Type': 'application/json'},
    ); // http.post()
    final Map<String, dynamic> responseData = json.decode(response.body);
    if(responseData.containsKey('idToken')) { // success response to signup/login
      final DateTime now = DateTime.now(); // current date and time
      final DateTime expiresIn = now.add(Duration(seconds: int.parse(responseData['expiresIn']))); // add then parse to DateTime
      _users.add(UserModel( // add to UserModel on signup/login success
        idToken: responseData['idToken'],
        email: responseData['email'],
        localId: responseData['localId'],
        expiresIn: expiresIn, // converted responseData['expiresIn'] then added to current time
      )); // add user to List<UserModel> _users
      // using SharePreferences to save user Id Token, email and local Id on device.
      final SharedPreferences prefs = await SharedPreferences.getInstance(); // for saving token on device
      prefs.setString('idToken', responseData['idToken']); // Save User ID Token on Device
      prefs.setString('email', responseData['email']); // Save User Email on Device
      prefs.setString('localId', responseData['localId']); // Save User Local ID on Device
      prefs.setString('expiresIn', expiresIn.toIso8601String()); // Save User Token Expiry Time to Device
      _navToHome( // Navigate to FPHome after successful Login/Signup
          token: responseData['idToken'],
          email: responseData['email'],
      ); // _navToHome()
    } else if(responseData.containsKey('error')) { // error handling
        showDialog( // error dialog
          context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error', style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),),
            content: Text('${responseData['error']['message']}', textScaleFactor: 1.25,),
            actions: <Widget>[OutlineButton(
              child: Text('Okay', textScaleFactor: 1.25,),
              onPressed: () {Navigator.of(context).pop();},
            )], // actions: FlatButton()
          ); // AlertDialog()
      }); // showDialog()
    }// if: success response to signup/login
    setState(() {isLoading = false;});
  } // _signupAction()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle + ': Log-in'),),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: appBackground,
          ), // Container()
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container( // App Title
                    child: Text(appTitle,
                        textScaleFactor: 3.0, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                        )), // App Title Text Styling
                  ), // Container for App Title
                  SizedBox(height: 60,),
                  _emailTextField(),
                  SizedBox(height: 5.0,),
                  _passwordTextField(),
                  _authMode == AuthMode.Signup ? SizedBox(height: 5.0,) : Container(),
                  _authMode == AuthMode.Signup ? _passwordConfirmTextField() : Container(),
                  SizedBox(height: 10.0,), // space between Text Fields and Button
                  Row( // AuthMode switch and Login button
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      OutlineButton( // AuthMode switch
                        onPressed: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
                          }); // setState()
                        }, // onPressed()
                        child: Text('Switch to ${_authMode == AuthMode.Login ? 'Signup' : 'Login'} Mode'),
                        borderSide: BorderSide(color: Theme.of(context).accentColor, width: 2.5),
                      ), // OutlineButton()
                      isLoading // Login/Signup button
                          ? CircularProgressIndicator()
                          : RaisedButton( // Login/Signup button
                        onPressed: _signupLoginAction,
                        elevation: 10.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('${_authMode == AuthMode.Signup ? 'Signup' : 'Login'}', style: TextStyle(color: Colors.white),),
                            SizedBox(width: 2.5,),
                            Icon(_authMode == AuthMode.Signup ? Icons.person_add : Icons.arrow_forward, color: Colors.white),
                          ], // children: <Widget>[]
                        ), // child: Row()
                        color: Theme.of(context).accentColor,
                      ), // RaisedButton()
                    ], // children: <Widget>
                  ), // Row()
                ], // children: <Widget>[]
              ), // child: Column,
            ), // child: Form()
          ), // SingleChildScrollView()
          Container( // App VERSION
            alignment: AlignmentDirectional.bottomCenter,
            padding: EdgeInsets.all(20.0),
            child: Text('version v$appVersion', style: TextStyle(color: Theme.of(context).accentColor),),
          ), // Container: App VERSION
        ], // children: <Widget>[]
      ), // body: Stack
    ); // return: Scaffold()
  } // Widget: build()
} // class: _AuthPageState