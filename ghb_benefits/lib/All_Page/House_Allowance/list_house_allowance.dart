
import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/House_controllers.dart';
import 'package:ghb_benefits/All_Models/house_model.dart';
import 'package:ghb_benefits/All_Page/House_Allowance/add_house_allowance.dart';
import 'package:ghb_benefits/All_Page/House_Allowance/detail_house_allowance.dart';
import 'package:ghb_benefits/All_Providers/provider_house.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

import 'package:ghb_benefits/color.dart';

import 'package:ghb_benefits/my_drawer.dart';
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

          context.read<HouseAllowanceProviders>().HouseAllowanceList = newhouse;
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอเบิกค่าเช่าบ้าน',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
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
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
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
    return Padding(
      padding: const EdgeInsets.all(2.0),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
          ),
          child: ListTile(
           leading: Icon(Icons.note),
            title: Text(notes.no),
            subtitle: Text(notes.status),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
             onTap: () {
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailHousePage(Notes : notes)));
                  },
          ),
        ),
    );
  }
}

