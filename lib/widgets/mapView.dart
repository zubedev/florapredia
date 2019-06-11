// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import '../models/cardModel.dart';

// CLASS: MAPVIEWWIDGET
class MapViewWidget extends StatelessWidget {
  // properties
  final CardModel imgCard;
  final List<CardModel> imgCards;

  // constructor
  MapViewWidget({
    this.imgCard,
    this.imgCards,
  });

  List<Marker> _getMarkers({CardModel imgCard, List<CardModel> imgCards}) {
    final List<Marker> markers = <Marker>[];
    if(imgCard != null) { // single imgCard
      markers.add(Marker('${imgCard.imgId}', '${imgCard.imgLabel}', imgCard.locLat, imgCard.locLng),);
    } else if(imgCards != null) { // multiple imgCards
      for(int i = 0; i < imgCards.length; i++) { // add markers for every card
        markers.add(Marker('${imgCards[i].imgId}', '${imgCards[i].imgLabel}', imgCards[i].locLat, imgCards[i].locLng),);
      } // for-loop add markers for every card
    } // if-check imgCards != null
    return markers;
  } // _getMarkers

  void showMap({CardModel imgCard, List<CardModel> imgCards}) {
    List<Marker> markers = <Marker>[];
    CameraPosition cameraPosition;
    if(imgCard != null) { // single imgCard
      markers = _getMarkers(imgCard: imgCard);
      cameraPosition = CameraPosition(Location(imgCard.locLat, imgCard.locLng), 15.0);
    } else if(imgCards != null) { // multiple imgCards
      markers = _getMarkers(imgCards: imgCards);
      cameraPosition = CameraPosition(Location(imgCards[0].locLat, imgCards[0].locLng), 15.0);
    } // if-check imgCards != null
    final mapView = MapView();
    mapView.show(
      MapOptions(
        showUserLocation: true,
        showMyLocationButton: true,
        initialCameraPosition: cameraPosition,
        mapViewType: MapViewType.normal,
        title: imgCard != null ? imgCard.locAddress : imgCards[0].imgUser,
      ), // MapOptions
      toolbarActions: [
        ToolbarAction('Close', 1),
      ], // toolbarActions[]
    ); // mapView.show()
    mapView.onToolbarAction.listen((int id) {if(id == 1) {mapView.dismiss();}});
    mapView.onMapReady.listen((_) {mapView.setMarkers(markers);});
  } // showMap

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: imgCard != null
          ? Text(imgCard.locAddress)
          : Text(imgCards[0].locAddress),
      onTap: () => imgCard != null
          ? showMap(imgCard: imgCard)
          : showMap(imgCards: imgCards)
    ); // return: GestureDetector()
  } // Widget: build()
} // class: MapView