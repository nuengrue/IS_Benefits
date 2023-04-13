import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/Dashborad/list_dashborad.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';

class AllDashboradPage extends StatefulWidget {
  @override
  State<AllDashboradPage> createState() => _AllDashboradPageState();
}

class _AllDashboradPageState extends State<AllDashboradPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard รายการอนุมัติสวัสดิการ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: iOrangeColor,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 10),

            //buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListDashborad(
                    buttonText: 'ภาพรวมรายการค่าช่วยเหลือค่ารักษาพยาบาล',
                    index: '/8',
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10),
            //buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListDashborad(
                    buttonText: 'ภาพรวมรายการค่าช่วยเหลือการศึกษาบุตร',
                    index: '/9',
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10),
            //buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListDashborad(
                    buttonText: 'ภาพรวมรายการเงินช่วยเหลือบุตร',
                    index: '/10',
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10),
            //buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListDashborad(
                    buttonText: 'ภาพรวมรายการค่าเช่าบ้านสำหรับพนักงาน',
                    index: '/11',
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10),
            //buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListDashborad(
                    buttonText: 'ภาพรวมรายการฌาปนกิจสงเคราะห์',
                    index: '/12',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //drawer: MyDrawer(),
    );
  }
}
