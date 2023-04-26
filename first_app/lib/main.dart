
//import 'package:first_app/Nav_Bar.dart';
import 'package:first_app/Nav_Bar.dart';
//import 'package:first_app/main_home_page.dart';
import 'package:flutter/material.dart';


 void main () { 
  runApp (MyApp());

 } 
  class MyApp extends StatelessWidget {
     // This widget is the root of your application . 
     @override 
     Widget build (BuildContext context) {
      return MaterialApp(

title: 'BELL',
home: NavBar(),
//home: MainHomePage(),

           ); // MaterialApp

       } 
       
}

