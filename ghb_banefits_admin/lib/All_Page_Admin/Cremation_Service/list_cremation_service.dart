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
  @override
  State<ListCremationServiceAdminPage> createState() => _ListCremationServiceAdminPageState();
}

class _ListCremationServiceAdminPageState extends State<ListCremationServiceAdminPage> {
  List<CremationServiceAdmin> Cremations = List.empty();
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

          context.read<CremationServiceAdminProviders>().CremationServiceAdminList = newCremation;
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอสมัครฌาปนกิจ',style: TextStyle(
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
        child: Consumer<CremationServiceAdminProviders>(
          builder: (context,CremationServiceAdminProviders data,child){
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.CremationServiceAdminList.length !=0 ? ListView.builder(
              itemCount: data.CremationServiceAdminList.length,
              itemBuilder: (context,index){

                return CardList(data.CremationServiceAdminList[index],index);
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
             drawer: MyDrawer(),
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
          child: ListTile(
           leading: Icon(Icons.note),
            title: Text(notes.no),
            subtitle: Text(notes.status),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
             onTap: () {
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailCremationServiceAdminPage(Notes : notes ,Indexs: index)));
                  },
          ),
        ),
    );
  }
}
