// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
//import 'package:flutter/rendering.dart'; // for UI debug, uncomment.
import 'shared/globals.dart';
import 'shared/ui_elements.dart';
import 'pages/auth.dart';

// MAIN: FLORAPREDIA
void main() {
  // for UI debug, uncomment and set to true.
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true;
  MapView.setApiKey(mapApiKey);
  runApp(FloraPredia());
} // main()

// CLASS: FLORAPREDIA
class FloraPredia extends StatelessWidget {
/*  // properties
  final String _appTitle = 'FloraPredia';
  final BoxDecoration _appBackground = BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
          Colors.white.withOpacity(0.25),
          BlendMode.dstATop),
      image: AssetImage('assets/bg.jpg'),
      repeat: ImageRepeat.repeat, // not needed with BoxFit.cover
    ), // image: DecorationImage()
  ); // decoration: BoxDecoration()*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true, // for UI debug, uncomment -> true.
      title: appTitle,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: AuthPage(), // if saved prefs doesn't exist, go to AuthPage()
    ); // return: MaterialApp()
  } // Widget: build()
} // class: FloraPredia
