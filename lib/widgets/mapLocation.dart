// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:map_view/map_view.dart';
import 'package:location/location.dart' as loc;
import 'dart:convert';
import '../shared/globals.dart';
import '../models/locationModel.dart';

// CLASS: MAPLOCATION
class MapLocation extends StatefulWidget {
  // properties
  final Function setLocation;

  //constructor
  MapLocation({@required this.setLocation});

  @override
  State<StatefulWidget> createState() {
    return _MapLocationState();
  } // State: createState()
} // class: MapLocation

// CLASS: _MAPLOCATIONSTATE
class _MapLocationState extends State<MapLocation> {
  // properties
  bool isLoading = false;
  LocationModel _locationModel;
  final FocusNode _addressInputFocusNode = FocusNode();
  final TextEditingController _addressTextController = TextEditingController();
  Uri _staticMapUri;
  
  @override
  void initState() {
    super.initState();
    _addressInputFocusNode.addListener(_updateLocation);
    _getCurrentLocation();
  } // initState()

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  } // dispose()

  void _updateLocation() {
    if(!_addressInputFocusNode.hasFocus && _addressTextController.text.isNotEmpty) { // update when focus lost
      setState(() {_getStaticMapAdd(_addressTextController.text);});
    } // if-statement
  } // _updateLocation

  void _getStaticMapAdd(String addInput) async {
    setState(() {isLoading = true;}); // loading
    if(addInput.isEmpty) { // do not continue if addInput is empty!
      setState(() {
        isLoading = false;
        _staticMapUri = null;
      }); // setState()
      widget.setLocation(null); // reset location
      return;
    } // if-statement
    final Uri uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/geocode/json',
        {'address': addInput, 'key': mapApiKey},
    ); // uri: address
    await _getLocationData(uri);
    _getStaticMapUri();
  } // getStaticMap()

  void _getStaticMapCoord(loc.LocationData locData) async {
    if(this.mounted) {setState(() {isLoading = true;});} // loading
    final Uri uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/geocode/json',
        {'latlng': '${locData.latitude.toString()},${locData.longitude.toString()}',
        'key': mapApiKey},
    ); // Uri uri
    await _getLocationData(uri);
    _getStaticMapUri();
  } //_getStaticMapCoords

  Future<Null> _getLocationData(Uri uri) async {
    final http.Response response = await http.get(uri);
    final responseBody = json.decode(response.body);
    _locationModel = LocationModel(
      latitude: responseBody['results'][0]['geometry']['location']['lat'],
      longitude: responseBody['results'][0]['geometry']['location']['lng'],
      address: responseBody['results'][0]['formatted_address'],
    ); // _locationModel
    widget.setLocation(_locationModel);
  } // _getLocationData

  void _getStaticMapUri() {
    final StaticMapProvider staticMapViewProvider = StaticMapProvider(mapApiKey);
      _addressTextController.text = _locationModel.address;
      _staticMapUri = staticMapViewProvider.getStaticUriWithMarkers(
        [Marker('pos','Pos',_locationModel.latitude,_locationModel.longitude)],
        center: Location(_locationModel.latitude,_locationModel.longitude),
        maptype: StaticMapViewType.roadmap,
      ); // _staticMapUri
      if(this.mounted) {setState(() {isLoading = false;});} // finished loading
  } // _getStaticMapUri

  void _getCurrentLocation() async {
    final location = await loc.Location().getLocation();
    _getStaticMapCoord(location);
  } // _getCurrentLocation
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            decoration: InputDecoration(
                labelText: 'Address',
                filled: true,
                fillColor: Colors.white,
            ), // Decoration for AddressTextField
            focusNode: _addressInputFocusNode,
            controller: _addressTextController,
            validator: (String value) {
              if(_locationModel == null || value.isEmpty) {
                return 'no valid location found';
              } // if-statement
            }, // validator
          ), // TextFormField()
        ), // Container: AddressTextField
        SizedBox(height: 5.0,),
        isLoading
            ? CircularProgressIndicator()
            : _staticMapUri == null
              ? Container()
              : Image.network(_staticMapUri.toString()),
        OutlineButton( // get Current Location using GPS
          child: Text('Tap here to get Current Location', style: TextStyle(color: Theme.of(context).accentColor),),
          onPressed: () {
            _getCurrentLocation();
          }, // onPressed()
          borderSide: BorderSide(color: Theme.of(context).accentColor, width: 1.0,),
        ), // OutlineButton()
      ], // children: <Widgets>
    ); // return: Column
  } // Widget: build()
} // class: _MapLocationState