
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/my_drawer.dart';




class MyDashboardPage extends StatefulWidget {
  @override
  State<MyDashboardPage> createState() => _MyDashboardPageState();
}

class _MyDashboardPageState extends State<MyDashboardPage> {
  //final _formKey = GlobalKey<FormState>();
  //final user = FirebaseAuth.instance.currentUser!;


  @override

 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Dashboard',style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
      backgroundColor: iBlueColor,),


      body: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'GHB',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),
                        ),
                        Text(
                          ' Benefit' 
                          //+ user.email!
                          ,
                          style: TextStyle(fontSize: 28, color:iOrangeColor),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: iGreyColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.person),
                        color: iOrangeColor,
                        onPressed: () {
                        //  Navigator.of(context).push(MaterialPageRoute(
                          //    builder: (context) => ()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              */

              SizedBox(height: 10),
              /*
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hi!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: iBlueColor,
                          ),
                        ),
                        Text(
                          '  ' 
                          + user.email!
                          ,
                          style: TextStyle(fontSize: 18, color:iBlueColor),
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
              */
              SizedBox(height: 20),

       /// my dash border
       Container(

        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 25.0),
          
          child: Text('My Dashboard', textAlign: TextAlign.left,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:iBlueColor),),

        ),
       ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                
            child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 400,
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
                    Text(
                      'ค่ารักษาพยาบาล',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                            SizedBox(
                              height: 100,
                              child: PieChart(
                                PieChartData(

                          startDegreeOffset: 30,
                                  sections: [
                                    //
                                    PieChartSectionData(
                                      color: Colors.blue,
                                      value: 20000,
                                      showTitle: false,
                                      radius: 25,
                                    ),
                                    PieChartSectionData(
                                      color: Colors.green,
                                      value: 20000,
                                      showTitle: false,
                                      radius: 25,
                                    ),
                                  ], //
                                ),
                              ),
                            ),
                    const Divider(),
                    Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                   Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เงินที่ใช้ได้',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '32000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        ),
                      ],
                    ),
                                                  Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เงินที่ใช้ไป',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '8000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        ),
                      ],
                    ),
                    Row(
                                        children: [
                        Expanded(
                          child: Text(
                            'วงเงินตามสิทธิ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '40000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        ),
                      ],
                    ),
                                  ],   
                    ),
                    

                  ],
                ),
            ),
 
            ///
            Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                //height: double.infinity,
                width: 400,
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
                    Text(
                      'ค่าช่วยเหลือการศึกษาบุตร',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 9, 28, 235),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                            SizedBox(
                              height: 100,
                              child: PieChart(
                                PieChartData(
                                  startDegreeOffset: 30,
                                  sections: [
                                    //
                                    PieChartSectionData(
                                      color: Colors.blue,
                                      value: 32000,
                                      showTitle: false,
                                      radius: 25,
                                    ),
                                    PieChartSectionData(
                                      color: Colors.green,
                                      value: 8000,
                                      showTitle: false,
                                      radius: 25,
                                    ),
                                  ], //
                                ),
                              ),
                            ),
                    const Divider(),
                    Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                   Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เงินที่ใช้ได้',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '32000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        ),
                      ],
                    ),
                                                  Row(
                      children: [
                        Expanded(
                          child: Text(
                            'เงินที่ใช้ไป',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '8000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        ),
                      ],
                    ),
                    Row(
                                        children: [
                        Expanded(
                          child: Text(
                            'วงเงินตามสิทธิ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                                        '40000',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                        ),
                      ],
                    ),

                                  ],   
                    ),
                    

                  ],
                ),
            ),
          ],
        ),
               ),
             ),
            ],
            
          ),

        ),
       drawer: MyDrawer(),
    );
  }

 
}



