
import 'package:flutter/material.dart';


class EducationPage extends StatefulWidget {
  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
 //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text('สร้างรายการ'),


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
            ],
            
          ),
      ),
    );

  }
}

 