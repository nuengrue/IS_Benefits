/*
import 'package:flutter/material.dart';

import '../medical/add_medical_page.dart';


class MedicalPage extends StatefulWidget {
  @override
  State<MedicalPage> createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
 //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('สร้างรายการขอเบิกค่ารักษาพยาบาล'),
         actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddMedPage()));
            },
          ),
        ],


      ),
         body: SingleChildScrollView(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

              Container(     
               // padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)
                    ),
                  ),
                ),
                          SizedBox(
              height: 20,
          ),
              Container(     
               margin:  const EdgeInsets.only(bottom: 50.0),
             padding: const EdgeInsets.all(8.0),
                height: 250,
                width: 500,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.amber,
                  ),
              // ),
             child:  Positioned(
              bottom: 0,
              left: 0,
                child: SizedBox(
                   
                  height: 100,
                  width: 50,
                  child: Column(
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text("",textAlign: TextAlign.right,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text("",textAlign: TextAlign.right,),
                      ),
                                            Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text("",textAlign: TextAlign.right,),
                      ),
                                            Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text("",textAlign: TextAlign.right,),
                      ),


                    ],
                  ),
               ),
               ),
               
               ),
                                         SizedBox(
              height: 20,
          ),
                       Container(     
               margin:  const EdgeInsets.only(bottom: 50.0),
             padding: const EdgeInsets.all(8.0),
                height: 250,
                width: 500,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white,
                  ),
              // ),
             child:  Positioned(
              bottom: 0,
              left: 0,
                child: SizedBox(
                   
                  height: 100,
                  width: 50,
                  child: Column(
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.all(8.0),

                      child:  TextFormField(
                  style:
                  TextStyle(fontSize: 10.0, color: Colors.black),
                  decoration: InputDecoration(
                    prefix: Icon(Icons.email, size: 10,),
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  )
              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text("57315 : หนึ่งฤทัย พวงแก้ว",textAlign: TextAlign.right,),
                      ),
                                            Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text("57315 : หนึ่งฤทัย พวงแก้ว",textAlign: TextAlign.right,),
                      ),
                                            Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Text("57315 : หนึ่งฤทัย พวงแก้ว",textAlign: TextAlign.right,),
                      ),


                    ],
                  ),
               ),
               ),
               
               ),
            ],
            
          ),
      ),
    );

  }
}

 */