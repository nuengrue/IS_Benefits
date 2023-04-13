
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
      appBar: AppBar(title: Text('GHB Benefit Admin',textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
      backgroundColor: iBlueColor,
      
      actions: [
        IconButton(
                        icon: Icon(Icons.logout),
                        color: iWhiteColor,
                        onPressed: () {
                           // FirebaseAuth.instance.signOut();
                        },
                      ),
      ],),


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
                          style: TextStyle(fontSize: 18, color:iBlueColor),
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              //SizedBox(height: 25),
              // Container(
              //   height: 200,

              //  child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25),
              //   child: Container(
              //    // width: 250,
              //     padding: EdgeInsets.all(20),
              //     decoration: BoxDecoration(
              //       color: Colors.pink[300],
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               'ประกาศแจ้งข่าวสาร',
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 24,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               'ร่วมมือ ร่วมใจ บริจาคสิ่งของเพื่อน้องๆ',
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 16,
              //               ),
              //             ),
                         
              //           ],
              //         ),
              //         SizedBox(height: 20),
              //              Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
 
              //             Text(
              //               "โดย ฝ่ายทรัพยากรบุคคล ส่วนสวัสดิการ",
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 16,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

                /*
                child: StreamBuilder<List<AddCard>>(
                    stream: listcard(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //final cars = snapshot.data!;
                        final card = snapshot.data;
                        return buildcards(card!);
                      } else if (snapshot.hasError) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return const Center(child: Text("No Data Received"));
                      }
                    }),*/
              // ),
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ButtonMenu(
                //       iconImagePath: Icons.notifications,
                //       buttonText: 'แจ้งสถานะ',
                //       index: '/7',
                //     ),
                //     ButtonMenu(
                //       iconImagePath: Icons.note,
                //       buttonText: 'รายงาน',
                //       index: '/8',
                //     ),

                //   ],
                // ),

            ],
            
          ),

        ),
       drawer: MyDrawer(),
      //bottomNavigationBar: _buildbottomNavigationBar(),
       //bottomNavigationBar:  
       /*
       NavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      elevation: 0,
      backgroundColor: iBlueColor,
        onPressed: () {
          
          
          
        },
        child: Icon(Icons.add,size: 35,),
      ),
      */
    ); 
  }

  /*
   Widget buildcars(List<carInfo> cars) => PageView.builder(
    scrollDirection: Axis.horizontal,
    controller: _controller,
    itemCount: !cars.isEmpty ? cars.length : 1,
    itemBuilder: (context, index) {
        //return InkWell(
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cars[index].Brand.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  cars[index].Img.toString(),
                  height: 50,
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
              cars[index].Model.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cars[index].Color.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  cars[index].Licence.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  cars[index].Refeul.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
       // );

          },
          );
          */
}


// Widget _buildbottomNavigationBar() { 
  
//     int _selectedIndex = 0;
//     final List<Widget> screens = [];
    
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: iGreyColor,
//           spreadRadius: 5,
//           blurRadius: 10
//         )
//       ]),
//       child: ClipRRect(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),

//         ),
        
//         child: BottomNavigationBar(
//           backgroundColor: iWhiteColor,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           selectedItemColor: iOrangeColor,
//           unselectedItemColor: iGreyColor,

//           items: [
//             BottomNavigationBarItem(
//               label: 'Home',
//               icon: Icon(Icons.home_rounded,size: 30),
//                ),
//                         BottomNavigationBarItem(
//               label: 'Profile',
//               icon: Icon(Icons.person_rounded,
//               size: 30)
//               ),

//           ],
//             currentIndex: _selectedIndex, //New
//             //onTap: _onItemTapped, 
              
//         ),

        
//       ),

//   );
  

// }






