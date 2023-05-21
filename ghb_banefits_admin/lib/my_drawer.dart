
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Cremation_Service/list_cremation_service.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/list_education_page.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/House_Allowance/list_house_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Medical/list_medical_page.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_Child_Allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_Cremation_Service.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_Education.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_House_Allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Report/Report_Medical.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_master.dart';
import 'package:ghb_banefits_admin/Dashborad/all_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/child_allowances_dashborad.dart';
import 'package:ghb_banefits_admin/Dashborad/list_Reports.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/test.dart';
import 'package:provider/provider.dart';


//import 'package:flutter/cupertino.dart';

class MyDrawer extends StatefulWidget {
  //final Function(int) onMenuTap;
  const MyDrawer({Key? key
      //,
      // required this.onMenuTap,
      })
      : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
    final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: iOrangeColor,
              ),
              accountName: Consumer<filedEmployeeProviders>(
          builder: (context, value, child) {
            String greeting = '';
                if(value.Empnameemp.toString().isNotEmpty)
                    {
                    greeting = '${value.Empnameemp}';
                    }
          return Text('$greeting',style: TextStyle(fontFamily: 'Sarabun',),);
          },
          ),
              // Text(user.email!),
              accountEmail: Text(user.email!,style: TextStyle(fontFamily: 'Sarabun',),),
              currentAccountPicture: CircleAvatar(
                backgroundColor: iWhiteColor,
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Icon(Icons.person),
                  /*
                child: Image.asset(
                  "images/user.jpg",
                  height: 200,
                  width: 200,
                ),
                */
              )
                  //child: Image.asset('images/user.jpg')
                  ),
            ),
            /*
      const DrawerHeader(
        decoration: BoxDecoration(
          color: iBlueColor,
        ),

       // child: Text('Drawer Header'),
      ),
      */
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('หน้าหลัก'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainHomeAdminPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: const Text('Dashboard รายการอนุมัติสวัสดิการ'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllDashboradPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.medical_information),
              title: const Text('ค่าช่วยเหลือค่ารักษาพยาบาล'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListMedicalAdminPage(Status:"Total All")));
              },
            ),
            ListTile(
              leading: Icon(Icons.cast_for_education),
              title: const Text('ค่าช่วยเหลือการศึกษาบุตร'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListEducationAdminPage(Status:"Total All")));
              },
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: const Text('เงินช่วยเหลือบุตร'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListChildAllowanceAdminPage(Status:"Total All")));
              },
            ),
            ListTile(
              leading: Icon(Icons.home_repair_service),
              title: const Text('ค่าเช่าบ้านสำหรับพนักงาน'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListHouseAllowanceAdminPage(Status:"Total All")));
              },
            ),
            ListTile(
              leading: Icon(Icons.cyclone),
              title: const Text('ฌาปนกิจสงเคราะห์'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListCremationServiceAdminPage(Status:"Total All")));
              },
            ),
            //  ListTile(
            //   leading: Icon(Icons.note),
            //   title: const Text('รายงานค่ารักษาพยาบาล'),
            //   onTap: () {
            //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyApp()));
            //   },
            // ),
  //                       ListTile(
  //             leading: Icon(Icons.note),
  //             title: const Text('รายงานค่าช่วยเหลือการศึกษาบุตร'),
  //             onTap: () {
  //               Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportEducationPage()));
  //             },
  //           ),
  //  ListTile(
  //             leading: Icon(Icons.note),
  //             title: const Text('รายงานค่าช่วยเหลือบุตร'),
  //             onTap: () {
  //               Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportChildAllowancePage()));
  //             },
  //           ),
  //                                   ListTile(
  //             leading: Icon(Icons.note),
  //             title: const Text('รายงานค่าเช่าบ้านของพนักงาน'),
  //             onTap: () {
  //               Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportHouseAllowancePage()));
  //             },
  //           ),
  //  ListTile(
  //             leading: Icon(Icons.note),
  //             title: const Text('รายงานสมัครฌาปนกิจสงเคราะห์'),
  //             onTap: () {
  //               Navigator.of(context).push(MaterialPageRoute( builder: (context) => const ReportCremationServicePage()));
  //             },
  //           ),
          ],
        ),
      ),
      /*
      color: Colors.white,
      padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("images/user.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("สวัสดี คุณ หนึ่งฤทัย",                   
                  style: TextStyle(fontSize: 16, 
                        color: Colors.black ,
                        fontWeight: FontWeight.bold,
                        ),
                        ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    Navigator.pop(context);
                  }, 
                  icon:const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  ),
                  //),
              ],
          ),
          SizedBox(
              height: 20,
          ),

          Column(
            children: List.generate(
              menus.length,
               (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom:4.0),
                  child: AnimatedContainer(
                    duration:  const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    decoration: initialIndex == index ? activeDecoration : BoxDecoration(),
                    child: ListTile(
                      onTap: () {
                        print("$index " + menus[index]);
                        setState(() {
                          initialIndex = index;
                        });
                       // widget.onMenuTap(index);
                      },
                      title: Text(
                        menus[index],
                       style: initialIndex == index ? activeTextStyle : inactiveTextStyle,
                       ),
                      leading: Icon(icons[index],
                      color: initialIndex == index ? Colors.blueAccent : Colors.black ,
                      ),
                    ),
                  ),
                );

               },
               
               ),
          ),
         /* SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black,
          thickness: 0.5,
          ),
          ListTile(
            title: Text("Profile"),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text("ออกจากระบบ"),
             leading: Icon(Icons.logout),
          ),*/
        ],
        
      ),
      */
    );
  }
}
