
//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFApi{
    static Future<File> loadAsset(String path) async {
      final data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();
      return _storeFile(path, bytes);
    }
static Future<File> _storeFile(String url, List<int> bytes) async {
  final filename = basename(url);
  final dir = await getApplicationDocumentsDirectory();
  
  final file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes, flush: true);
  return file;
  

}
}

