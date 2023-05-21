//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/cremation_service_controllers.dart';
import 'package:ghb_benefits/All_Models/cremation_service_model.dart';
import 'package:ghb_benefits/All_Page/Cremation_Service/add_cremation_service.dart';
import 'package:ghb_benefits/All_Page/Cremation_Service/detail_cremation_service.dart';
import 'package:ghb_benefits/All_Providers/provider_cremation.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/my_drawer.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class ListCremationServicePage extends StatefulWidget {
  @override
  State<ListCremationServicePage> createState() => _ListCremationServicePageState();
}

class _ListCremationServicePageState extends State<ListCremationServicePage> {
  List<CremationService> Cremations = List.empty();
  bool isloading = false;
  late int count ;

  CremationServiceController controller =
      CremationServiceController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getCremationService(context);
      }

   void   _getCremationService(BuildContext context) async {
            var newCremation = await controller.fetchCremationService();

                         newCremation.sort((a,b) => a.no.compareTo(b.no));

             Cremations =  newCremation.reversed.toList();

          context.read<CremationServiceProviders>().CremationServiceList = Cremations;
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอสมัครฌาปนกิจสงเคราะห์',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
      backgroundColor: iBlueColor,
      //  actions: <Widget>[
      //     IconButton(
      //       icon: const Icon(Icons.add),
      //       // tooltip: 'Show Snackbar',
      //       onPressed: () {
      //         Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => AddCremationServicePage()));
      //       },
      //     ),
      //   ],
        ),
          floatingActionButton: FloatingActionButton(  
        child: Icon(Icons.add),  
        backgroundColor: iBlueColor,  
        foregroundColor: Colors.white,  
            onPressed: () {

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddCremationServicePage()));
            },
      ), 
             body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CremationServiceProviders>(
          builder: (context,CremationServiceProviders data,child){
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.CremationServiceList.length !=0 ? ListView.builder(
              itemCount: data.CremationServiceList.length,
              itemBuilder: (context,index){

                return CardList(data.CremationServiceList[index],index);
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
            ): GestureDetector(onTap: (){
              //  Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => AddCremationServicePage()));
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,fontFamily: 'Sarabun',),)));
          },
        ),
      ),
             drawer: MyDrawer(),
      );
  }
}

 class CardList extends StatelessWidget {
  final CremationService notes;
  int index;
  CardList(this.notes,this.index);
  @override
  Widget build(BuildContext context) {
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
                  Expanded(child: Text('ผู้จัดการศพ',
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  Expanded(child: Text(notes.managername, textAlign: TextAlign.end,)),
                ],),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('ความสัมพนธ์',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(notes.relationship, textAlign: TextAlign.end,)),
                    ],
                  ),                 
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
                    Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailCremationServicePage(Notes : notes)));
                    },
            ),
          
        ),
    );
  }
}
