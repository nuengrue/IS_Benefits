import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_Child_Allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_Cremation_Service.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_Education.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_House_Allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_Medical.dart';
import 'package:ghb_banefits_admin/button_menu.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';


class ListReports extends StatelessWidget {



  //final String buttonText;
  const ListReports({Key? key,
  //required this.iconImagePath,

  }) : super(key: key);

  @override
Widget build(BuildContext context) {
      final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายงานสวัสดิการ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: iWhiteColor,),),backgroundColor: iOrangeColor,
      
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
                
                        SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
          children: [
           InkWell(
            onTap: () {
                                Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportMedicalPage()));
            },

        child:     Container(
                          height: 50,
                width: width,
               
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                ),
  margin: EdgeInsets.all(5),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "รายงานค่ารักษาพยาบาล",

      style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: iBlueColor,
              ),
    ),
  ),
),

            ),

          ],
        ),
                  ),            

                                      SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
          children: [
           InkWell(
            onTap: () {
                                Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportEducationPage()));
            },

        child:     Container(
                          height: 50,
                width: width,
               
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                ),
  margin: EdgeInsets.all(5),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "รายงานค่าช่วยเหลือการศึกษาบุตร",

      style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: iBlueColor,
              ),
    ),
  ),
),

            ),

          ],
        ),
                  ),            

                                      SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
          children: [
           InkWell(
            onTap: () {
                                Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportChildAllowancePage()));
            },

        child:     Container(
                          height: 50,
                width: width,
               
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                ),
  margin: EdgeInsets.all(5),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "รายงานค่าช่วยเหลือบุตร",

      style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: iBlueColor,
              ),
    ),
  ),
),

            ),
                         
          ],
        ),
                  ),            

                                      SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
          children: [
           InkWell(
            onTap: () {
                                Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportHouseAllowancePage()));
            },

        child:     Container(
                          height: 50,
                width: width,
               
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                ),
  margin: EdgeInsets.all(5),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "รายงานค่าเช่าบ้านของพนักงาน",

      style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: iBlueColor,
              ),
    ),
  ),
),

            ),
                         

          ],
        ),
                  ),            

                                      SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
          children: [
           InkWell(
            onTap: () {
                                Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportCremationServicePage()));
            },

        child:     Container(
                          height: 50,
                width: width,
               
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 6.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                ),
  margin: EdgeInsets.all(5),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "รายงานสมัครฌาปนกิจ",

      style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: iBlueColor,
              ),
    ),
  ),
),

            ),
                       

          ],
        ),
                  ),            


             
            //buttons
 
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}


