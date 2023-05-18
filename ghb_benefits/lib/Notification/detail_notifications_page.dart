//import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Models/Notifications_model.dart';
import 'package:ghb_benefits/All_Providers/provider_notifications.dart';
import 'package:ghb_benefits/Notification/notifications_page.dart';
import 'package:ghb_benefits/color.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

//import 'package:flutter/widgets.dart';

class DetailNotifacationsPage extends StatefulWidget {


  const DetailNotifacationsPage({super.key, required this.Notes, required this.Indexs});

  // Declare a field that holds the Todo.
  final Notifications Notes;

 final int Indexs;

  @override
  State<DetailNotifacationsPage> createState() => _DetailNotifacationsPageState();
}

class _DetailNotifacationsPageState extends State<DetailNotifacationsPage> {
  late int _Indexs;

  late int _read = 0;
      void initState() {
        super.initState();
        // _getNotificationsmodify(context);
      }

   void   _getNotificationsmodify() async {
    _Indexs = widget.Indexs.toInt();
    _read = 1;
       Provider.of<NotificationsProviders>(context, listen: false)
        .modify(_Indexs, _read);
    print(_Indexs);
    print(_read);
        final docStatus = FirebaseFirestore.instance
        .collection('Notifications')
        .doc(widget.Notes.id);
            docStatus.update({'read': _read});
            print("done");

             Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationsPage(),
        ),
      );
      }
  // void ModifydataApprove() async {
  //   _Indexs = widget.Indexs.toInt();
  //   _read = _read;
  //      Provider.of<NotificationsProviders>(context, listen: false)
  //       .modify(_Indexs, _read);
  //   print("done");
    
  //   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
         title: Text('รายละเอียดการแจ้งเตือน',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,    
      ),
      body: SingleChildScrollView(


          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
 Row(
                      children: [
                     
                         Text(
                            widget.Notes.createDate,
                            textAlign: TextAlign.start,style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                    
                      ],
                    ),
                     Row(
                      children: [
                     
                         Text(
                            widget.Notes.title,
                            textAlign: TextAlign.start,style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                      ),
                          ),
                    
                      ],
                    ),

                    const Divider(),
                      Row(
                      children: [

                        Expanded(
                          child: Text(
                            widget.Notes.content,
                            textAlign: TextAlign.start,style: TextStyle(fontFamily: 'Sarabun',),
                          ),
                        ),
                      ],
                    ),

                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                        children: [
                            Expanded(
                            child: Text(
                              '',
                              textAlign: TextAlign.start,style: TextStyle(fontFamily: 'Sarabun',),
                            ),
                          ),
                          if(widget.Notes.read == 0) ...[
                            Expanded(
                                          child:               ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: iBluebuttonColor,
                  onPrimary: Colors.white,
                  shadowColor: iBluebuttonColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(200, 40), //////// HERE
                ),
                onPressed: () {
                  _getNotificationsmodify();
                },
                child: Text('รับทราบ',textAlign: TextAlign.end,style: TextStyle(fontFamily: 'Sarabun',),),
              ),
                          ),              
                          ] else ...[

                                                      Expanded(
                            
                            child:   Text("")
                          ),
                          ]

                        ],
                    ),
                     ),
                  ],
                ),
              ),







              SizedBox(
                height: 10,
              ),
                 
              SizedBox(
                height: 30,
              ),

              ///
            ],
          
        ),
      ),
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
        title: Text('รายละเอียดเอกสาร',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
),
      
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}