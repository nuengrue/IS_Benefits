
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/House_controllers.dart';
import 'package:ghb_benefits/All_Models/house_model.dart';
import 'package:ghb_benefits/All_Page/House_Allowance/add_house_allowance.dart';
import 'package:ghb_benefits/All_Page/House_Allowance/detail_house_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_house.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

import 'package:ghb_benefits/color.dart';

import 'package:ghb_benefits/my_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ListHouseAllowanceePage extends StatefulWidget {
  @override
  State<ListHouseAllowanceePage> createState() => _ListHouseAllowanceePageState();
}

class _ListHouseAllowanceePageState extends State<ListHouseAllowanceePage> {
 
  List<HouseAllowance> houses = List.empty();
  
   HouseAllowanceController controller =
      HouseAllowanceController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getHouseAllowancee(context);
      }

   void   _getHouseAllowancee(BuildContext context) async {
            var newhouse = await controller.fetchHouseAllowance();
            
                                     newhouse.sort((a,b) => a.no.compareTo(b.no));

             houses =  newhouse.reversed.toList();

          context.read<HouseAllowanceProviders>().HouseAllowanceList = houses;
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar( title: Text('รายการคำขอค่าเช่าบ้านของพนักงาน',style: TextStyle(
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
      //             MaterialPageRoute(builder: (context) => AddHouseAllowancePage()));
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
                  MaterialPageRoute(builder: (context) => AddHouseAllowancePage()));
            },
      ), 
             body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HouseAllowanceProviders>(
          builder: (context,HouseAllowanceProviders data,child){
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.HouseAllowanceList.length !=0 ? ListView.builder(
              itemCount: data.HouseAllowanceList.length,
              itemBuilder: (context,index){

                return CardList(data.HouseAllowanceList[index],index);
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
               Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddHouseAllowancePage()));
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,fontFamily: 'Sarabun',),)));
          },
        ),
      ),
             drawer: MyDrawer(),
      );
  }
}

 class CardList extends StatelessWidget {
  final HouseAllowance notes;
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
                  Expanded(child: Text('ดำรงตำแหน่ง',
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  Expanded(child: Text(notes.position, textAlign: TextAlign.end,)),
                ],),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('วันที่ดำรงแหน่ง',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(notes.positiondate, textAlign: TextAlign.end,)),
                    ],
                  ),                 
                  Row(
                    children: [
                      Expanded(child: Text('ประเภทการเช่าบ้าน',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(notes.typehouse, textAlign: TextAlign.end,)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('จำนวนเงินร้องขอ',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(myFormat.format(int.parse(notes.moneyhouse)), textAlign: TextAlign.end,)),
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
                    Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailHousePage(Notes : notes)));
                    },
            ),
          
        ),
    );
  }
}

