import 'package:flutter/material.dart';
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
          'GHB Benefit Admin',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: iOrangeColor,
          ),
        ),
        backgroundColor: iBlueColor,
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
                        'Hi!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: iBlueColor,
                        ),
                      ),
                      Text(
                        ' j '
                        //+ user.email!
                        ,
                        style: TextStyle(fontSize: 18, color: iBlueColor),
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
                  buttonText: 'ค่าเช่าบ้าน',
                  index: '/5',
                ),
                ButtonMenu(
                  iconImagePath: Icons.cyclone,
                  buttonText: 'ฌาปนกิจ',
                  index: '/6',
                ),
              ],
            ),
            SizedBox(height: 10),
            //buttons
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
