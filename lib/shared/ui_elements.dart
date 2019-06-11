// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';

// PROPERTIES --- GLOBALS
final String appTitle = 'FloraPedia'; // title
final BoxDecoration appBackground = BoxDecoration( // background
  image: DecorationImage(
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(
        Colors.white.withOpacity(0.25),
        BlendMode.dstATop),
    image: AssetImage('assets/bg.jpg'),
    repeat: ImageRepeat.repeat, // not needed with BoxFit.cover
  ), // image: DecorationImage()
); // decoration: BoxDecoration()