//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/cremation_service_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/cremation_service_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Cremation_Service/detail_cremation_service.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_cremation.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';

import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class ListCremationServiceAdminPage extends StatefulWidget {
    const ListCremationServiceAdminPage(
      // ignore: non_constant_identifier_names
      {super.key, required this.Status});

  // Declare a field that holds the Todo.
  final String Status;
  @override
  State<ListCremationServiceAdminPage> createState() => _ListCremationServiceAdminPageState();
}

class _ListCremationServiceAdminPageState extends State<ListCremationServiceAdminPage> {
  List<CremationServiceAdmin> Cremations = List.empty();
      List<CremationServiceAdmin> _Datalist = List.empty();
  bool isloading = false;
  late int count ;

  CremationServiceAdminController controller =
      CremationServiceAdminController(FirebaseServicesAdmin());
      

      void initState() {
        super.initState();
        _getCremationServiceAdmin(context);
      }

   void   _getCremationServiceAdmin(BuildContext context) async {
            var newCremation = await controller.fetchCremationServiceAdmin();

                                                newCremation.sort((a,b) => a.no.compareTo(b.no));

             Cremations =  newCremation.reversed.toList();

          context.read<CremationServiceAdminProviders>().CremationServiceAdminList = Cremations;
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
              title: Text('รายการคำขอสมัครฌาปนกิจ',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                            color: iWhiteColor,),),backgroundColor: iOrangeColor,
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
        child: Consumer<CremationServiceAdminProviders>(
          builder: (context,CremationServiceAdminProviders data,child){
   if(widget.Status.toString() == "Total All"){

  _Datalist = data.CremationServiceAdminList;

}
else{

    _Datalist = data.CremationServiceAdminList.where((x) => x.status == widget.Status.toString()).toList();
} 
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
              //     MaterialPageRoute(builder: (context) => AddCremationServicePage()));
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
          },
        ),
      ),
            //  drawer: MyDrawer(),
      );
  }
}

 class CardList extends StatelessWidget {
  final CremationServiceAdmin notes;
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
                 child: Card(
            child: ListTile(
            //  leading: Icon(Icons.note),
              title: Row(  children: [
                  Expanded(child: Text('ผู้ร้องขอ',
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  Expanded(child: Text(notes.name, textAlign: TextAlign.end,)),
                ],),
              subtitle: Column(
                children: [
                   Row(
                    children: [
                  Expanded(child: Text('ผู้จัดการศพ',
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  Expanded(child: Text(notes.managername, textAlign: TextAlign.end,)),
                    ],
                  ),                     
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
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailCremationServiceAdminPage(Notes : notes ,Indexs: index)));
                    },
            ),
          ),
        ),
    );
  }
}
