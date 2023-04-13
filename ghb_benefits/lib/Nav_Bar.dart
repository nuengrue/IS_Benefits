/*

import 'package:flutter/material.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/page/add_education_page.dart';
import 'package:ghb_benefits/page/add_medical_page.dart';
import 'package:ghb_benefits/page/detail_medical_page.dart';
import 'package:ghb_benefits/page/education_page.dart';


import 'package:ghb_benefits/page/profile_page.dart';

import 'page/detail_education_page.dart';
import 'page/notification.dart';



class NavBar extends StatefulWidget{

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>{
  int index = 0;
  final screen = [

       MainHomePage(),
   DetailEducationPage(),
       ProfilePage(),
       AddMedPage(),
    //Center(child: Text('Mail',style: TextStyle(fontSize: 72))),
      //  Center(child: Text('A',style: TextStyle(fontSize: 72))),
       //     Center(child: Text('B',style: TextStyle(fontSize: 72))),
       //         Center(child: Text('C',style: TextStyle(fontSize: 72))),
         //           Center(child: Text('D',style: TextStyle(fontSize: 72))),
  // MainHomePage(),
   //DetailMedicalPage(),
   //DetailEducationPage(),
      // ProfilePage(),
    //SeventhPage(),
    //ProfilePage(),
    

  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: screen[index],
    bottomNavigationBar:  NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: iOrangeColor,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),

      ) ,
        
      child: NavigationBar(
        height: 60,

        
        backgroundColor:  iGreyColor,
        selectedIndex: index,
        onDestinationSelected: (index) =>  
             setState (() => this.index = index),
        destinations: [

           NavigationDestination(
            icon: Icon(Icons.home_outlined), 
            label: 'Home'
            ),
                  NavigationDestination(
            icon: Icon(Icons.home_outlined), 
            label: 'Home'
            ),
                    NavigationDestination(
            icon: Icon(Icons.add), 
            label: 'Create'
            ),
                    NavigationDestination(
            icon: Icon(Icons.menu), 
            label: 'Menu'
            ),
            /*
                    NavigationDestination(
            icon: Icon(Icons.person), 
            label: ''
            ),
                    NavigationDestination(
            icon: Icon(Icons.menu), 
            label: ''
            ),
            */
        ],
       ),
    ),
    
  );
 

}
*/