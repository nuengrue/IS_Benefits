//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/child_allowance_controllers.dart';
import 'package:ghb_benefits/All_Models/child_allowane_model.dart';
import 'package:ghb_benefits/All_Page/Child_Allowances/add_child_allowance.dart';
import 'package:ghb_benefits/All_Page/Child_Allowances/detail_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_child_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_dashboard.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/my_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class ListChildAllowancePage extends StatefulWidget {
  @override
  State<ListChildAllowancePage> createState() => _ListChildAllowancePageState();
}

class _ListChildAllowancePageState extends State<ListChildAllowancePage> {
  List<ChildAllowance> allowances = List.empty();
  bool isloading = false;
  late int count ;
    late int countsum = 0 ;

  ChildAllowanceController controller =
      ChildAllowanceController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getChildAllowance(context);
      }

   void   _getChildAllowance(BuildContext context) async {
            var newAllowance = await controller.fetchChildAllowance();
var countshow = newAllowance.where((x) => x.status == "อนุมัติ").length ;

setState(() {
 countsum =  countshow;
});
          context.read<ChildAllowanceProviders>().ChildAllowanceList = newAllowance;
      }
      
/*
  void _getChildAllowance(BuildContext context) async {
    var newAllowance = await controller.fetchChildAllowance();

    context.read<ChildAllowanceProviders>().ChildAllowanceList = newAllowance;

    //setState(() => allowances = newAllowance);
  }
*/

  Widget build(BuildContext context) {

    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอเบิกค่าช่วยเหลือบุตร',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
       actions: <Widget>[
                    
          // IconButton(
          //   icon: const Icon(Icons.add),
          //   // tooltip: 'Show Snackbar',
          //   onPressed: () {

          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => AddChildAllowancePage()));
          //   },
          // ),
        ],),

      //         floatingActionButton: FloatingActionButton(  
      //   child: Icon(Icons.add),  
      //   backgroundColor: iBlueColor,  
      //   foregroundColor: Colors.white,  
      //       onPressed: () {

      //         Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => AddChildAllowancePage()));
      //       },
      // ), 
        /*
body:FutureBuilder<List<ChildAllowance>>(
    future: _getChildAllowance(context),
    
    builder: (context, snapshot) {

      if (!snapshot.hasData) return Container();
      //List<ChildAllowance>? notes = snapshot.data;
          
                        return CardList(allowances);
    },
  ),
  */

 
            body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ChildAllowanceProviders>(
          builder: (context,ChildAllowanceProviders data,child){
             print(data.ChildAllowanceList);
//              setState(() {
//   count = data.ChildAllowanceList.length;
// });
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.ChildAllowanceList.length !=0 ? ListView.builder(
              itemCount: data.ChildAllowanceList.length,
              
              itemBuilder: (context,index){
                print(data.ChildAllowanceList.length);


                return CardList(data.ChildAllowanceList[index],index);

                /*Card(
                child: ListTile(
                  title: Text(data.getChildAllowane[index].no),
                  subtitle: Text(data.getChildAllowane[index].status),
                  trailing: Icon(Icons.arrow_circle_right),
                  onTap: () {
                  //  Navigator.push( context,MaterialPageRoute(builder: (context) =>SubListChildAllowancePage(listdatamedical)));
                  },
                ),
              );
                */
                
                

              },
            ): GestureDetector(
              //onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddChildAllowancePage()));},
              child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(fontFamily: 'Sarabun',color: iBlueColor,),)));
          },
        ),
      ),
     


             drawer: MyDrawer(),
      persistentFooterButtons: <Widget>[
             if (countsum.toString() == '3') ...[
                   
 Text('ท่านได้ขอเบิกบุตรครบกำหนดแล้ว: ${countsum.toString()} คน',style: TextStyle(
                      fontSize: 15,
                      color: iOrangeColor,
                      fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    ),),

    ] else ...[
  //  Text('ท่านได้ใช้วงเงินตามสิทธิ์ครบกำหนดแล้ว: ${value.Childage.toString()}'),

         FloatingActionButton(  
        child: Icon(Icons.add),  
        backgroundColor: iBlueColor,  
        foregroundColor: Colors.white,  
            onPressed: () {

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddChildAllowancePage()));
            },
      ),
    ]


      ]

    
                      
      );

  }
}

 class CardList extends StatelessWidget {
  final ChildAllowance notes;
  int index;
  CardList(this.notes,this.index);
  
  @override
  Widget build(BuildContext context) {
                                  NumberFormat myFormat =
                          NumberFormat.decimalPattern('en_us');
    return Padding(
      padding: const EdgeInsets.all(2.0),

        child: Container(
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
          
            child: ListTile(
            //  leading: Icon(Icons.note),
              title: Row(  children: [
                      Expanded(child: Text('ชื่อบุตร',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(notes.namechild, textAlign: TextAlign.end,)),
                ],),
              subtitle: Column(
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(child: Text('ชื่อบุตร',
                  //               // textAlign: TextAlign.left,
                  //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  //     Expanded(child: Text(notes.namechild, textAlign: TextAlign.end,)),
                  //   ],
                  // ),                 
                  // Row(
                  //   children: [
                  //     Expanded(child: Text('จำนวนเงินร้องขอ',
                  //               // textAlign: TextAlign.left,
                  //               style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  //     Expanded(child: Text(myFormat.format(int.parse(notes.amountreceipt)), textAlign: TextAlign.end,)),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Expanded(child: Text('วันที่บันทึก',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(notes.savedate, textAlign: TextAlign.end,)),
                    ],
                  ),
                ],
              ),
              trailing: Text(notes.status,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',color: iBlueColor,),),
               onTap: () {
                    Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailChildAllowancePage(Notes : notes)));
                    },
            ),
          
        ),
    );
  }
}

