
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/child_allow/model.dart';
import 'package:ghb_benefits/main_home_page.dart';




class DetailStatusAdminPage extends StatelessWidget {

    final user = FirebaseAuth.instance.currentUser!;
     List<ChildAll> orders = List.empty();
   //   orderController controller = orderController(FirebaseServices());
Stream<List<ChildAll>> adminstatus() => FirebaseFirestore.instance
    .collection('ChildAllowance')
    //.where('email',isEqualTo: user.email.toString())
    .snapshots().map((snapshot) => snapshot.docs.map((doc) => ChildAll.fromJson(doc.data())).toList());
  
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดการสถานะการจัดส่ง'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MainHomePage()));
            },
          ),
        ],
      ),


      body: StreamBuilder<List<ChildAll>>(
                    stream: adminstatus(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                      {
                        final cars = snapshot.data!;
          
                        return buildordersadmin(cars);
                        /*return ListView(
                          children: casr.map(buildcars).toList(),
                        );
                        */
                      }
                      else {
                        return Center(child : CircularProgressIndicator());
                      }
                    }
                  ),
    );
  }
    Widget buildordersadmin(List<ChildAll> orders) => ListView.builder(
    itemCount: !orders.isEmpty ? orders.length : 0,
    itemBuilder: (context, index) {
           if(index >= 0)
      {
 return InkWell(
            //  onTap: () { Navigator.push(context,MaterialPageRoute
           //   (builder: (context) => UpdateStatusAdminPage(order: orders[index])));},

    child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orders[index].no.substring(1,8),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                              'images/profile.png',
                              height: 50,
                            ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                              'จำนวนเงิน ${orders[index].empcode}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                        Text(
                              orders[index].namepartner,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                      ],
                    ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                                                    Text(
                                'สถานะการจัดส่ง',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        Text(
                              orders[index].status,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                         
                      ],
                    ),

                  ],
                ),
              ),
            ),
    

          );
      }
         else{
              return const Center(child: Text("No Data"));
            }

          },
          
          );
}

 