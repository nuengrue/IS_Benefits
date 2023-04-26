import 'package:first_app/detail_medical_page.dart';
import 'package:first_app/education_page.dart';
import 'package:first_app/main_home_page.dart';
//import 'package:first_app/medical_page.dart';
import 'package:first_app/profile_page.dart';
import 'package:flutter/material.dart';


class NavBar extends StatefulWidget{

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>{
  int index = 0;
  final screen = [
    //Center(child: Text('Mail',style: TextStyle(fontSize: 72))),
      //  Center(child: Text('A',style: TextStyle(fontSize: 72))),
       //     Center(child: Text('B',style: TextStyle(fontSize: 72))),
       //         Center(child: Text('C',style: TextStyle(fontSize: 72))),
         //           Center(child: Text('D',style: TextStyle(fontSize: 72))),
    //Center(child: Text('Mail',style: TextStyle(fontSize: 72))),
    MainHomePage(),
   DetailMedicalPage(),
   EducationPage(),
    ProfilePage(),
    Center(child: Text('D',style: TextStyle(fontSize: 72))),
    

  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: screen[index],
    bottomNavigationBar:  NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.amber.shade100,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),

      ) ,
        
      child: NavigationBar(
        height: 60,
        backgroundColor:  Colors.white,
        selectedIndex: index,
        onDestinationSelected: (index) =>  
             setState (() => this.index = index),
        destinations: [
                  NavigationDestination(
            icon: Icon(Icons.home_outlined), 
            label: 'หน้าหลัก'
            ),
                    NavigationDestination(
            icon: Icon(Icons.medical_services), 
            label: 'medical'
            ),
                    NavigationDestination(
            icon: Icon(Icons.school), 
            label: 'Education'
            ),
                    NavigationDestination(
            icon: Icon(Icons.person), 
            label: 'Education'
            ),
                    NavigationDestination(
            icon: Icon(Icons.menu), 
            label: 'เมนู'
            ),
        ],
       ),
    ),
    
  );
 

}