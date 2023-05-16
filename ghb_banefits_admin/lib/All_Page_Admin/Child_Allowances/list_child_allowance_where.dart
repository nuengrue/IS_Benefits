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

class ListChildAllowanceWhereAdminPage extends StatefulWidget {
  const ListChildAllowanceWhereAdminPage(
      // ignore: non_constant_identifier_names
      {super.key, required this.Status});

  // Declare a field that holds the Todo.
  final String Status;


  @override
  State<ListChildAllowanceWhereAdminPage> createState() => _ListChildAllowanceWhereAdminPageState();
}

class _ListChildAllowanceWhereAdminPageState extends State<ListChildAllowanceWhereAdminPage> {
  List<ChildAllowanceAdmin> allowances = List.empty();
    List<ChildAllowanceAdmin> _Datalist = List.empty();
  bool isloading = false;
  late int count ;

  ChildAllowanceAdminController controller =
      ChildAllowanceAdminController(FirebaseServicesAdmin());
      

      void initState() {
        super.initState();
        _getChildAllowanceAdmin(context);
      }

   void   _getChildAllowanceAdmin(BuildContext context) async {


// if(widget.Status.toString() == "Total All" ){
            var newAllowance = await controller.fetchChildAllowanceAdmin();
          context.read<ChildAllowanceAdminProviders>().ChildAllowanceAdminListwhere = newAllowance;

// }
//             var newAllowance = await controller.fetchChildAllowanceAdmin();
//             var newAllowancewhere = newAllowance.where((x) => x.status == widget.Status.toString()).toList();
//           context.read<ChildAllowanceAdminProviders>().ChildAllowanceAdminListwhere = newAllowancewhere;
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
              title: 
             Text('รายการคำขอเบิกค่าช่วยเหลือบุตร',
            // Text(widget.Status.toString(),
            style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
if(widget.Status.toString() == "Total All"){

  _Datalist = data.ChildAllowanceAdminListwhere;

}
else{

    _Datalist = data.ChildAllowanceAdminListwhere.where((x) => x.status == widget.Status.toString()).toList();
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
              
              },
            ): GestureDetector(
              //onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddChildAllowancePage()));},
              child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
          },
        ),
      ),
     
            //  drawer: MyDrawer(),
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
            title: Text(notes.no.toString()),
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

