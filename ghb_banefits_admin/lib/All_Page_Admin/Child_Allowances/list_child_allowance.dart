//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/child_allowane_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/detail_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';

import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class ListChildAllowanceAdminPage extends StatefulWidget {
  @override
  State<ListChildAllowanceAdminPage> createState() => _ListChildAllowanceAdminPageState();
}

class _ListChildAllowanceAdminPageState extends State<ListChildAllowanceAdminPage> {
  List<ChildAllowanceAdmin> allowances = List.empty();
  bool isloading = false;
  late int count ;

  ChildAllowanceAdminController controller =
      ChildAllowanceAdminController(FirebaseServicesAdmin());
      

      void initState() {
        super.initState();
        _getChildAllowanceAdmin(context);
      }

   void   _getChildAllowanceAdmin(BuildContext context) async {
            var newAllowance = await controller.fetchChildAllowanceAdmin();

          context.read<ChildAllowanceAdminProviders>().ChildAllowanceAdminList = newAllowance;
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
        child: Consumer<ChildAllowanceAdminProviders>(
          builder: (context,ChildAllowanceAdminProviders data,child){
             //print(data.ChildAllowanceAdminList);
//              setState(() {
//   count = data.ChildAllowanceList.length;
// });
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.ChildAllowanceAdminList.length !=0 ? ListView.builder(
              itemCount: data.ChildAllowanceAdminList.length,
              
              itemBuilder: (context,index){
              //  print(data.ChildAllowanceAdminList.length);


                return CardList(data.ChildAllowanceAdminList[index],index);

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
              child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
          },
        ),
      ),
     
             drawer: MyDrawer(),
      );
  }
}


 class CardList extends StatelessWidget {
  final ChildAllowanceAdmin notes;
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
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailChildAllowanceAdminPage(Notes : notes, Indexs : index)));
                  },
          ),
        ),
    );
  }
}

