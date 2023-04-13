
//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/Medical_Controller.dart';
import 'package:ghb_benefits/All_Models/medical_model.dart';
import 'package:ghb_benefits/All_Page/Medical/add_medical_page.dart';
import 'package:ghb_benefits/All_Page/Medical/detail_medical_page.dart';
import 'package:ghb_benefits/All_Providers/provider_medical.dart';
import 'package:ghb_benefits/All_Services/servics.dart';

import 'package:ghb_benefits/color.dart';

import 'package:ghb_benefits/my_drawer.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';


class ListMedicalPage extends StatefulWidget {
  @override
  State<ListMedicalPage> createState() => _ListMedicalPageState();
}

class _ListMedicalPageState extends State<ListMedicalPage> {
    List<Medical> medicals = List.empty();
  bool isloading = false;
  late int count ;

  MedicalController controller =
      MedicalController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getMedical(context);
      }

   void   _getMedical(BuildContext context) async {
            var newMedical = await controller.fetchMedical();

          context.read<MedicalProviders>().MedicalList = newMedical;
      }
  @override
    Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอเบิกค่ารักษาพยาบาล',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
      backgroundColor: iBlueColor,
       actions: <Widget>[
                    
          IconButton(
            icon: const Icon(Icons.add),
            // tooltip: 'Show Snackbar',
            onPressed: () {

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddMedPage()));
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
        child: Consumer<MedicalProviders>(
          builder: (context,MedicalProviders data,child){
             print(data.MedicalList);
//              setState(() {
//   count = data.ChildAllowanceList.length;
// });
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.MedicalList.length !=0 ? ListView.builder(
              itemCount: data.MedicalList.length,
              
              itemBuilder: (context,index){
                print(data.MedicalList.length);


                return CardList(data.MedicalList[index],index);

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
  final Medical notes;
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
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailMedicalPage(Notes : notes)));
                  },
          ),
        ),
    );
  }
}
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('รายการคำขอเบิก'),
//            actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.add),
//             // tooltip: 'Show Snackbar',
//             onPressed: () {
//               Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => AddMedPage()));
//             },
//           ),
//         ],
//         ),
//         body: ListView.builder(
//             itemCount: ListdataMedicalmodal.length,
//             itemBuilder: (context, index) {
//               ListdataMedical listdatamedical = ListdataMedicalmodal[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(listdatamedical.idreceiptnumber),
//                   subtitle: Text(listdatamedical.savedate),
//                   trailing: Icon(Icons.arrow_circle_right),
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 SubDetailMedicalPage(listdatamedical)));
//                   },
//                 ),
//               );
//             }));
//   }
// }


//import 'dart:developer';
/*
import 'package:flutter/material.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/medical/add_medical_page.dart';
import 'package:ghb_benefits/medical/medical_model.dart';
import 'package:ghb_benefits/medical/provider.dart';
import 'package:ghb_benefits/medical/subdetail_medical_page.dart';
import 'package:ghb_benefits/my_drawer.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class DetailMedicalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอเบิกค่ารักษาพยาบาล',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
      backgroundColor: iBlueColor,
       actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddMedPage()));
            },
          ),
        ],),
        /*
        appBar: AppBar(
          title: const Text('รายการคำขอเบิก'),
           actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddMedPage()));
            },
          ),
        ],
        ),
        */
             body:  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Consumer<MedicalModelProviders>(
                       builder: (context,MedicalModelProviders data,child){
                        // return data.getChildAllowane.length !=0 ? ListView.builder(
                         return data.getmedicalModel.length !=0 ? ListView.builder(
                itemCount: data.getmedicalModel.length,
                itemBuilder: (context,index){
             
                  return CardList(data.getmedicalModel[index],index);
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
                  
                  
                  CardList(data.getmedicalModel[index],index);
                },
                         ): GestureDetector(onTap: (){
                 Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddMedPage()));
                         },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
                       },
                     ),
                   ),
             
             drawer: MyDrawer(),
      );
  }

 
}

 class CardList extends StatelessWidget {
  final MedicalModel notes;
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
            title: Text(notes.idreceiptnumber),
            subtitle: Text(notes.status),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
             onTap: () {
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>SubDetailMedicalPage(Notes : notes)));
                  },
          ),
        ),
    );
  }
}
*/
