import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
//import 'package:ghb_benefits/Nav_Bar.dart';
import 'package:ghb_benefits/page/education_page.dart';
import 'package:ghb_benefits/page/medical_page.dart';
//import 'package:ghb_benefits/education_page.dart';
//import 'package:ghb_benefits/medical_page.dart';
import 'package:ghb_benefits/my_drawer.dart';
import 'package:ghb_benefits/page/profile_page.dart';
//import 'package:ghb_benefits/profile_page.dart';

class home_page extends StatefulWidget{
  const home_page({Key? key}) : super(key: key);

  @override
  _HomePagerState createState() => _HomePagerState();

}

class _HomePagerState extends State<home_page>{
  //int indexPage = 0;
  //final List fram = const [ProfilePage(),MedicalPage(),EducationPage(),];
final  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

@override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
         icon: const Icon(
          Icons.menu,
         ),
        
        ),

      ),
      drawer: MyDrawer(
       // onMenuTap: (page) {
       //   print(page);
       //   Navigator.pop(context);
        /*  setState(() {
            indexPage = page;
          });
        },*/
      ),
      
      //body: fram[indexPage],
               body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

           /* Container(
              height: 100,
             // margin:  const EdgeInsets.only(bottom: 100.0),
             // padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
               color: Colors.amber,
               borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
               ),
              ),
              child: Row(
                children: [
                  
                  Text('   Hi Nuengruethai',
                  style: TextStyle(fontSize: 18, 
                        color: Color.fromARGB(255, 9, 28, 235) ,
                        fontWeight: FontWeight.bold,
                        ),
                  ),
                  Spacer(),
                  //
                   Container(
                    height: 50,
                    
             // margin:  const EdgeInsets.only(bottom: 50.0),
               //padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                
                borderRadius: BorderRadius.circular(20.0),

              ),
              child: Image.asset("images/user.jpg",
              height: 50),
              //Image.asset("images/user.jpg")
            ),
//                  Image.asset("images/user.jpg")
                  
                ],
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
             Container(
              height: 400,
             margin:  const EdgeInsets.only(bottom: 50.0),
             padding: const EdgeInsets.all(8.0),
             
              decoration: BoxDecoration(
               //color: Colors.grey,
               color: Colors.white.withOpacity(0.50),
              borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                                   Expanded(
                    child: Container(
 
                    height: 400,
                    decoration : BoxDecoration(color: Colors.white,
                    //borderRadius: const BorderRadius.all(Redius.circular(10)),
                    ),
                      child: Column(
                        children: [Text("ค่ารักษาพยาบาล", //
                        style: TextStyle(fontSize: 18, 
                        fontWeight: FontWeight.w500,
                        //color: 
                         ),
                         ),
                         SizedBox(height: 200,
                         child: PieChart(
                          PieChartData(
                            sections: [//
                              PieChartSectionData(
                                color: Colors.blue,
                                value: 80),
                              PieChartSectionData(value: 20),
                            ],//
                            
                          ),
                          
                         ),
                         

                         ),
                         
	

			Text(' ยอดเงินที่ใช้ได้ 32,000 บาท',                   style: TextStyle(fontSize: 18, 
                        color: Color.fromARGB(255, 9, 28, 235) ,
                        fontWeight: FontWeight.bold,
                        ),),
			Text('0ากบอดวงเงินตามสิทธิ  40,000 บาท'),
            
            			Text('ใช้ไปแล้ว'),
                  Text('20.00 %'),
                  Text('จำนวนเงิน 8,000 บาท'),
                   ElevatedButton(
              
             onPressed: () => Navigator.pushNamed(context, '/2'),
             child: const Text('ยื่นคำขอเบิกค่ารักษาพยาบาล'),

            
            ),


                         ],//
                                    
                      ),
                    ),
                    
                  ),

                  
                ],
              ),
            ),
///
             Padding(
              padding: const EdgeInsets.all(5.0),
            ),
             Container(
              height: 400,
             margin:  const EdgeInsets.only(bottom: 100.0),
             padding: const EdgeInsets.all(8.0),
             
              decoration: BoxDecoration(
               //color: Colors.grey,
               color: Colors.white.withOpacity(0.50),
              borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                                   Expanded(
                    child: Container(
 
                    height: 400,
                    decoration : BoxDecoration(color: Colors.white,
                    //borderRadius: const BorderRadius.all(Redius.circular(10)),
                    ),
                      child: Column(
                        children: [Text("ค่าช่วยเหลือการศึกษาบุตร", //
                        style: TextStyle(fontSize: 18, 
                        fontWeight: FontWeight.w500,
                        //color: 
                         ),
                         ),
                         SizedBox(height: 200,
                         child: PieChart(
                          PieChartData(
                            sections: [//
                              PieChartSectionData(
                                color: Colors.blue,
                                value: 80),
                              PieChartSectionData(value: 20),
                            ],//
                            
                          ),
                          
                         ),
                         

                         ),
                         
	

			Text(' ยอดเงินที่ใช้ได้ 32,000 บาท',                   style: TextStyle(fontSize: 18, 
                        color: Color.fromARGB(255, 9, 28, 235) ,
                        fontWeight: FontWeight.bold,
                        ),),
			Text('จากยอดวงเงินตามสิทธิ  40,000 บาท'),
            
            			Text('ใช้ไปแล้ว'),
                  Text('20.00 %'),
                  Text('จำนวนเงิน 8,000 บาท'),
                                     ElevatedButton(
              
                        onPressed: () {
            
          },
             child: const Text('ยื่นคำขอเบิกค่าช่วยเหลือการศึกษาบุตร'),
            
            ),


                         ],//
                      ),
                    ),
                    
                  ),

                  
                ],
              ),
            ),

          ],
        ),
      )
    );

  }
  }


class NavBar extends StatefulWidget{

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>{
  int index = 0;
  final screen = [
    home_page(),
    home_page(),
    EducationPage(),
   // ProfilePage(),
    MyDrawer(),
    

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
            label: 'หน้าหลัก'
            ),
                    NavigationDestination(
            icon: Icon(Icons.school), 
            label: 'หน้าหลัก'
            ),
                    NavigationDestination(
            icon: Icon(Icons.person), 
            label: 'หน้าหลัก'
            ),
                    NavigationDestination(
            icon: Icon(Icons.logout_outlined), 
            label: 'หน้าหลัก'
            ),
        ],
       ),
    ),
    
  );
 

}