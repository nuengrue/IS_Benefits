
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/House_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/House_Allowance/detail_house_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';

import 'package:provider/provider.dart';


class ListHouseAllowanceAdminPage extends StatefulWidget {
  @override
  State<ListHouseAllowanceAdminPage> createState() => _ListHouseAllowanceAdminPageState();
}

class _ListHouseAllowanceAdminPageState extends State<ListHouseAllowanceAdminPage> {
 
  List<HouseAllowanceAdmin> houses = List.empty();
  
   HouseAllowanceAdminController controller =
      HouseAllowanceAdminController(FirebaseServicesAdmin());
      

      void initState() {
        super.initState();
        _getHouseAllowanceAdmin(context);
      }

   void   _getHouseAllowanceAdmin(BuildContext context) async {
            var newhouse = await controller.fetchHouseAllowanceAdmin();

          context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = newhouse;
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
       actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            // tooltip: 'Show Snackbar',
            onPressed: () {

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MainHomeAdminPage()));
            },
          ),
        ],),
             body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<HouseAllowanceAdminProviders>(
          builder: (context,HouseAllowanceAdminProviders data,child){
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.HouseAllowanceAdminList.length !=0 ? ListView.builder(
              itemCount: data.HouseAllowanceAdminList.length,
              itemBuilder: (context,index){

                return CardList(data.HouseAllowanceAdminList[index],index);
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
              //     MaterialPageRoute(builder: (context) => AddHouseAllowancePage()));
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
          },
        ),
      ),
             drawer: MyDrawer(),
      );
  }
}

 class CardList extends StatelessWidget {
  final HouseAllowanceAdmin notes;
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
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailHouseAdminPage(Notes : notes ,Indexs: index)));
                  },
          ),
        ),
    );
  }
}

