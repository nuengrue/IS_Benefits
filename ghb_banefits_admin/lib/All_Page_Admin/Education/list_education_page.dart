//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Education_Controller.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/detail_education.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class ListEducationAdminPage extends StatefulWidget {
    const ListEducationAdminPage(
      // ignore: non_constant_identifier_names
      {super.key, required this.Status});

  // Declare a field that holds the Todo.
  final String Status;
  @override
  State<ListEducationAdminPage> createState() => _ListEducationAdminPageState();
}

class _ListEducationAdminPageState extends State<ListEducationAdminPage> {
  List<EducationAdmin> educations = List.empty();
  List<EducationAdmin> _Datalist = List.empty();
  bool isloading = false;
  late int count;

  EducationAdminController controller =
      EducationAdminController(FirebaseServicesAdmin());

  void initState() {
    super.initState();
    _getEducationAdmin(context);
  }

  void _getEducationAdmin(BuildContext context) async {
    var newEducation = await controller.fetchEducationAdmin();
                                                newEducation.sort((a,b) => a.no.compareTo(b.no));

             educations =  newEducation.reversed.toList();
    context.read<EducationAdminProviders>().EducationAdminList = educations;
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
        title: Text(
          'รายการคำขอช่วยเหลือการศึกษา',
          style: TextStyle(
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<EducationAdminProviders>(
          builder: (context, EducationAdminProviders data, child) {
            // return data.getChildAllowane.length !=0 ? ListView.builder(
if(widget.Status.toString() == "Total All"){

  _Datalist = data.EducationAdminList;

}
else{

    _Datalist = data.EducationAdminList.where((x) => x.status == widget.Status.toString()).toList();
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
                  )
                : GestureDetector(
                    onTap: () {
                      //  Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => AddEduPage()));
                    },
                    child: Center(
                        child: Text(
                      "ไม่พบรายการคำขอ",
                      style: TextStyle(
                        color: iBlueColor,fontFamily: 'Sarabun',
                      ),
                    )));
          },
        ),
      ),
      // drawer: MyDrawer(),
    );
  }
}

class CardList extends StatelessWidget {
  final EducationAdmin notes;
  int index;
  CardList(this.notes, this.index);
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
            )),
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
                  Expanded(child: Text('เลขที่ใบเสร็จ',
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                  Expanded(child: Text(notes.receiptnumber, textAlign: TextAlign.end,)),
                    ],
                  ),                        
                  Row(
                    children: [
                      Expanded(child: Text('ชื่อบุตร',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(notes.namechild, textAlign: TextAlign.end,)),
                    ],
                  ),                 
                  Row(
                    children: [
                      Expanded(child: Text('จำนวนเงินร้องขอ',
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Sarabun',),)),
                      Expanded(child: Text(myFormat.format(int.parse(notes.amountreceipt)), textAlign: TextAlign.end,)),
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
                    Navigator.push(                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailEducationAdminPage(Notes: notes, Indexs: index)));
                    },
            ),
          ),
      ),
    );
  }
}
