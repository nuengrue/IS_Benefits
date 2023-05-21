
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/House_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/house_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/House_Allowance/detail_house_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';


class ListHouseAllowanceAdminPage extends StatefulWidget {
    const ListHouseAllowanceAdminPage(
      // ignore: non_constant_identifier_names
      {super.key, required this.Status});

  // Declare a field that holds the Todo.
  final String Status;
  @override
  State<ListHouseAllowanceAdminPage> createState() => _ListHouseAllowanceAdminPageState();
}

class _ListHouseAllowanceAdminPageState extends State<ListHouseAllowanceAdminPage> {
 
  List<HouseAllowanceAdmin> houses = List.empty();
      List<HouseAllowanceAdmin> _Datalist = List.empty();
  
   HouseAllowanceAdminController controller =
      HouseAllowanceAdminController(FirebaseServicesAdmin());
      

      void initState() {
        super.initState();
        _getHouseAllowanceAdmin(context);
      }

   void   _getHouseAllowanceAdmin(BuildContext context) async {
            var newhouse = await controller.fetchHouseAllowanceAdmin();
             newhouse.sort((a,b) => a.no.compareTo(b.no));

             houses =  newhouse.reversed.toList();
          context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = houses;
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
                             leading: IconButton(
                  
                        
                         icon: Icon(Icons.arrow_back),
                          
                        color: iWhiteColor,
                        onPressed: () {
                            // FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainHomeAdminPage()));
                        },
                      ),
               title: Text('รายการคำขอค่าเช่าบ้านของพนักงาน',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,
                          ),),
                            backgroundColor: iOrangeColor,
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
if(widget.Status.toString() == "Total All"){

  _Datalist = data.HouseAllowanceAdminList;

}
else{

    _Datalist = data.HouseAllowanceAdminList.where((x) => x.status == widget.Status.toString()).toList();
}

  // count = data.ChildAllowanceAdminListwhere.length;
// });
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return _Datalist.length !=0 ? ListView.builder(
              itemCount: _Datalist.length,
              
              itemBuilder: (context,index){
              //  print(data.ChildAllowanceAdminList.length);
                            //  final testdat = data.ChildAllowanceAdminListwhere.where((x) => x.status == widget.Status).toList();
                            //  print(testdat);

                return CardList(_Datalist[index],index);
              
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
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,fontFamily: 'Sarabun',),)));
          },
        ),
      ),
            //  drawer: MyDrawer(),
      );
  }
}

 class CardList extends StatelessWidget {
  final HouseAllowanceAdmin notes;
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
          ),
          child: Card(
            child: ListTile(
            //  leading: Icon(Icons.note),
              title: Row(  children: [
                  Expanded(child: Text('ชื่อผู้ร้องขอ',
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  Expanded(child: Text(notes.name, textAlign: TextAlign.end,)),
                ],),
              subtitle: Column(
                children: [
                                    Row(
                    children: [
                  Expanded(child: Text('ดำรงตำแหน่ง',
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  Expanded(child: Text(notes.position, textAlign: TextAlign.end,)),
                    ],
                  ), 
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
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailHouseAdminPage(Notes : notes ,Indexs: index)));
                    },
            ),
          ),
        ),
    );
  }
}

