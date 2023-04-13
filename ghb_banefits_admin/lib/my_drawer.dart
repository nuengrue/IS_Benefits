
import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/test.dart';


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
    //final user = FirebaseAuth.instance.currentUser!;
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
                color: iBlueColor,
              ),
              accountName: Text('nuengruethai.p'),
              accountEmail: Text('nuengruethai.p@gmail.com'),
              currentAccountPicture: CircleAvatar(
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
                    builder: (context) => Test()));
              },
            ),
            ListTile(
              leading: Icon(Icons.medical_information),
              title: const Text('ค่าช่วยเหลือค่ารักษาพยาบาล'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Test()));
              },
            ),
            ListTile(
              leading: Icon(Icons.cast_for_education),
              title: const Text('ค่าช่วยเหลือการศึกษาบุตร'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Test()));
              },
            ),
            ListTile(
              leading: Icon(Icons.money),
              title: const Text('เงินช่วยเหลือบุตร'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Test()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home_repair_service),
              title: const Text('ค่าเช่าบ้านสำหรับพนักงาน'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Test()));
              },
            ),
            ListTile(
              leading: Icon(Icons.cyclone),
              title: const Text('ฌาปนกิจสงเคราะห์'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Test()));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.notifications),
            //   title: const Text('แจ้งสถานะรายการสวัสดิการ'),
            //   onTap: () {
            //    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationPage()));
            //   },
            // ),
            //             ListTile(
            //   leading: Icon(Icons.note),
            //   title: const Text('รายงานสวัสดิการ'),
            //   onTap: () {
            //     //Navigator.of(context).push(MaterialPageRoute( builder: (context) => NotificationPage()));
            //   },
            // ),

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
