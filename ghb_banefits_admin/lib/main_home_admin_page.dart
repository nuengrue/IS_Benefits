import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/Dashborad/list_Reports.dart';
import 'package:ghb_banefits_admin/button_menu.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';

class MainHomeAdminPage extends StatefulWidget {
  @override
  State<MainHomeAdminPage> createState() => _MainHomeAdminPageState();
}

class _MainHomeAdminPageState extends State<MainHomeAdminPage> {
  //final _formKey = GlobalKey<FormState>();
  //final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GHB Welfare Admin',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
            color: iWhiteColor,),),backgroundColor: iOrangeColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: iWhiteColor,
            onPressed: () {
              // FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'สวัสดี ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                          color: iBlueColor,
                        ),
                      ),
                      Text(
                        ' gggggg '
                        //+ user.email!
                        ,
                        style: TextStyle(fontSize: 18, fontFamily: 'Sarabun',color: iBlueColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            SizedBox(height: 10),

            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonMenu(
                  iconImagePath: Icons.dashboard,
                  buttonText: 'Dashboards',
                  index: '/1',
                ),
                ButtonMenu(
                  iconImagePath: Icons.medical_information,
                  buttonText: 'ค่ารักษาพยาบาล',
                  index: '/2',
                ),
              ],
            ),
            SizedBox(height: 10),
            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonMenu(
                  iconImagePath: Icons.cast_for_education,
                  buttonText: 'การศึกษาบุตร',
                  index: '/3',
                ),
                ButtonMenu(
                  iconImagePath: Icons.money,
                  buttonText: 'เงินช่วยเหลือบุตร',
                  index: '/4',
                ),
              ],
            ),
            SizedBox(height: 10),
            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonMenu(
                  iconImagePath: Icons.home_repair_service,
                  buttonText: 'ค่าเช่าบ้านพนักงาน',
                  index: '/5',
                ),
                ButtonMenu(
                  iconImagePath: Icons.cyclone,
                  buttonText: 'ฌาปนกิจสงเคราะห์',
                  index: '/6',
                ),
              ],
            ),
            SizedBox(height: 10),
            //buttons
                        Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
                  Column(
          children: [
           InkWell(
            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ListReports()));
            },
              child: Container(
                height: 120,
                width: 120,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(Icons.book,size: 70,
                  color: iOrangeColor,),
                  //Image.asset(iconImagePath),
                ),
              ),
            ),
                        SizedBox(height: 12),
            //text
            Text('รายงานสวัสดิการ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
              color: iBlueColor,
            ),
            ),
          ],
        ),

          Column(
          children: [
           InkWell(
            onTap: () {
              Navigator.pushNamed(context, '');
            },
              child: Container(
                height: 120,
                width: 120,
          //       padding: EdgeInsets.all(20),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey.shade400,
          //             blurRadius: 6.0,
          //             spreadRadius: 2.0,
          //           ),
          //         ],
          //       ),
          //       child: Center(
          //         child: Icon(Icons.book,size: 70,
          //         color: iOrangeColor,),
          //         //Image.asset(iconImagePath),
          //       ),
          //     ),
          //   ),
          //               SizedBox(height: 12),
          //   //text
          //   Text('',
          //   style: TextStyle(
          //     fontSize: 14,
          //     fontWeight: FontWeight.bold,
          //     color: iBlueColor,
            ),
            ),
          ],
        ),
                // ButtonMenu(
                //   iconImagePath: Icons.book,
                //   buttonText: 'รายงานสวัสดิการทั้งหมด',
                //   index: '/5',
                // ),
                
                
                           
              ],
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
