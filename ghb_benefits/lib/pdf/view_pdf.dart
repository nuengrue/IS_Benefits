
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class ViewPDFPage extends StatefulWidget {
  final File file;
  const ViewPDFPage({super.key, required this.file});
  @override
  State<ViewPDFPage> createState() => _ViewPDFPageState();
}

class _ViewPDFPageState extends State<ViewPDFPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;
  @override
  Widget build(BuildContext context) {
    
    final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: PDFView(
        filePath: widget.file.path,
       // swipeHorizontal: true,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) => setState(() => this.controller =controller),
        onPageChanged: (indexPage, _) => 
        setState(() =>
          this.indexPage = indexPage!),
        
      ),
    );
  }
}
