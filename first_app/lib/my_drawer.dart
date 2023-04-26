
import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';


class MyDrawer extends StatefulWidget{
  //final Function(int) onMenuTap;
  const MyDrawer({
    Key? key
    //,
   // required this.onMenuTap,
  }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();



}

class _MyDrawerState extends State<MyDrawer>{
  int initialIndex = 0;
  final activeTextStyle = TextStyle(color: Colors.blueAccent);
  final inactiveTextStyle = TextStyle(color: Colors.black);
  final activeDecoration = BoxDecoration(
     borderRadius: BorderRadius.circular(8),
     color: Colors.amber,
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
  Widget build(BuildContext context)
  {
    return Container(
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
    );
  }
}