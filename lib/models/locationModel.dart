// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';

// CLASS: LOCATIONMODEL
class LocationModel {
  // properties
  final double latitude;
  final double longitude;
  final String address;

  //constructor
  LocationModel({
    @required this.latitude,
    @required this.longitude,
    @required this.address,
  }); // LocationModel()
} // class: LocationModel