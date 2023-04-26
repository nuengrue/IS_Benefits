//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/All_Controllers/Education_Controller.dart';
import 'package:ghb_benefits/All_Models/education_model.dart';
import 'package:ghb_benefits/All_Providers/provider_education.dart';
import 'package:ghb_benefits/All_Services/servics.dart';
import 'package:ghb_benefits/color.dart';

import 'package:provider/provider.dart';
import 'add_education_page.dart';
import 'detail_education.dart';
import 'package:ghb_benefits/my_drawer.dart';
//import 'package:flutter/widgets.dart';

class ListEducationPage extends StatefulWidget {
  @override
  State<ListEducationPage> createState() => _ListEducationPageState();
}

class _ListEducationPageState extends State<ListEducationPage> {
    List<Education> educations = List.empty();
  bool isloading = false;
  late int count ;

  EducationController controller =
      EducationController(FirebaseServices());
      

      void initState() {
        super.initState();
        _getEducation(context);
      }

   void   _getEducation(BuildContext context) async {
            var newEducation = await controller.fetchEducation();

          context.read<EducationProviders>().EducationList = newEducation;

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
 var a =  "1993-04-01";
DateTime b =  DateTime.parse(a);
          var _age = calculateAge(b);

          print(_age);
      }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอช่วยเหลือการศึกษา',style: TextStyle(
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
                  MaterialPageRoute(builder: (context) => AddEduPage()));
            },
          ),
        ],),
             body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<EducationProviders>(
          builder: (context,EducationProviders data,child){
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.EducationList.length !=0 ? ListView.builder(
              itemCount: data.EducationList.length,
              itemBuilder: (context,index){

                return CardList(data.EducationList[index],index);
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
                  MaterialPageRoute(builder: (context) => AddEduPage()));
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
          },
        ),
      ),
             drawer: MyDrawer(),
      );
  }
}

 class CardList extends StatelessWidget {
  final Education notes;
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
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailEducationPage(Notes : notes)));
                  },
          ),
        ),
    );
  }
}

