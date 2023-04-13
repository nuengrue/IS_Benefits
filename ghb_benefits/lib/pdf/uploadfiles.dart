
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UploadFiles extends StatefulWidget {
  const UploadFiles({Key? key}) : super(key: key);

  @override
  State<UploadFiles> createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  String url = "";
  late int number;
  uploadDataToFirebase() async {

    number = Random().nextInt(10);

    FilePickerResult? resulta = await FilePicker.platform.pickFiles();
    // ignore: unused_local_variable
    //File pick = File(resulta?.files.single.path.toString());
    File pick = File(resulta!.files.single.path.toString());
    var file = pick.readAsBytesSync();

  PlatformFile filedetail = resulta.files.first;


    var filename = filedetail.name;

    String name = DateTime.now().microsecondsSinceEpoch.toString();
    var pdfFile = FirebaseStorage.instance.ref().child(name).child("/"+ filename.toString() +".pdf");
    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
    .collection("file")
    .doc()
    .set({'fileUrl':url,'num' : "file FDF" + filename.toString()});
    //.set({'fileUrl':url,'num' : "file FDF" + number.toString()});
    


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF"),
      ),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection("file").snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) 
        {
                    if(snapshot.hasData)
          {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          
                          itemBuilder: (context,i) {
                                    QueryDocumentSnapshot x =snapshot.data!.docs[i];
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => View(url: x['fileUrl'])));
                            },
                            child: Container(
                                        margin: EdgeInsets.symmetric(vertical: 10),
                                        child: Text(x["num"]),
                                      ),
                          );
            });

          //if(snapshot.hasData){
            /*
            return ListView.builder(itemBuilder: (context,(context, index) {
              
            }))
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(""),
            );
            */

          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: uploadDataToFirebase,child:Icon(Icons.add) ,),
    );
    
  }
}

class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;
   View({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF View"),
      ),
     body: SfPdfViewer.network(
      url,
      controller: _pdfViewerController,
    ),

    );
  }
}