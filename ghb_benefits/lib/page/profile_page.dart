/*
import 'package:flutter/material.dart';

import '../button_menu.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final _formKey = GlobalKey<FormState>();
    int initialIndex = 0;
  final activeTextStyle = TextStyle(color: Colors.blueAccent);
  final inactiveTextStyle = TextStyle(color: Colors.black);
  final activeDecoration = BoxDecoration(
     borderRadius: BorderRadius.circular(8),
     color: Colors.orange[100],
  ); // BoxDecoration

 final List<String> menus = ["หน้าหลัก",  "ค่ารักษาพยาบาล" ,"ค่าช่วยเหลือการศึกษาบุตร","Profile","ออกจากระบบ"];
 final List<IconData> icons = [
  Icons.home_outlined,
  Icons.medical_services,
  Icons.school,
  Icons.person,
  Icons.logout_outlined,

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfilePage'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "images/user.jpg",
                  height: 200,
                  width: 200,
                  //fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "สวัสดี คุณ หนึ่งฤทัย",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
         SizedBox(
              height: 20,
          ),


                     Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonMenu(
                  iconImagePath: 'images/healthcare.png',
                  buttonText: 'Car',
                  index: '/1',
                ),
                ButtonMenu(
                  iconImagePath: 'images/graduation.png',
                  buttonText: 'Order',
                  index: '/2',
                ),
                ButtonMenu(
                  iconImagePath: 'images/notification.png',
                  buttonText: 'Status',
                  index: '/3',
                ),
                
              ],
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

          ],
        ),
      ),
    );
  }
}
*/