import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<ui.Image> loadImageFromUrl(String url) async {
  final Uri resolved = Uri.base.resolve(url);
  final ByteData data = await NetworkAssetBundle(resolved).load("");
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final frame = await codec.getNextFrame();
  return frame.image;
}


  Future<ui.Image> fetchImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      return frameInfo.image;
    } else {
      throw Exception('Failed to load image');
    }
  }