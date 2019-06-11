// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';
import 'dart:io';
//import 'dart:typed_data';

// CLASS: IMGCLASSIFY
class ImgClassify {
  // properties
  final String _model = "assets/flora_16.tflite"; // MobileNet v2 with 92% accuracy
  final String _labels = "assets/flora_16_labels.txt"; // 16 classes with labels
  final File imgFile;

  // constructor
  ImgClassify({@required this.imgFile});

  Future _loadModel() async {
    Tflite.close(); // close any open session
    try {
      final String res = await Tflite.loadModel(
        model: _model,
        labels: _labels,
      ); // Tflite.loadModel()
      print(res);
    } catch(e) {
      print(e);
    } // try.catch()
  } // _loadModel

  Future<File> _imgPreprocess(File _image) async {
    final Directory tmpDir = await getTemporaryDirectory();
    final img.Image _decodedImage = img.decodeImage(File(_image.path).readAsBytesSync());
    final img.Image _croppedImage = img.copyResizeCropSquare(_decodedImage, 224);
    final File _savedImage = File('${tmpDir.path}/tmp.jpg')..writeAsBytesSync(img.encodeJpg(_croppedImage));
    return _savedImage;
  } // _imgPreprocess

  Future<List<dynamic>> predict(File _imgFile) async {
    await _loadModel();
    final File _imgProcessed = await _imgPreprocess(_imgFile);
    List<dynamic> predictions = await Tflite.runModelOnImage(
        path: _imgProcessed.path,
        imageMean: 127.5, // mobilenet: 127.5, resnet50: 117.0
        imageStd: 127.5, // mobilenet: 127.5, resnet50: 1.0
        numResults: 3,
        threshold: 0.1,
        asynch: true
    ); // Tflite.runModelOnImage()
    //print(predictions);
    _imgProcessed.deleteSync(); // delete temporary image file
    return predictions;
  } // predict()

/*
    Uint8List imageToByteListFloat32 (
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
*/

} // class: ImgClassify