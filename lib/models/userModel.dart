// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';

// CLASS: USERMODEL
class UserModel {
  // properties
  final String idToken;
  final String email;
  final String localId;
  final DateTime expiresIn;

  // constructor
  UserModel({
    @required this.idToken,
    @required this.email,
    @required this.localId,
    @required this.expiresIn,
  }); // UserModel()

} // class: UserModel