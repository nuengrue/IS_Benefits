/*
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:ghb_benefits/child_allowance/child_allowane_model.dart';
import 'package:ghb_benefits/main_home_page.dart';

//import '../nav_bar.dart';

//import 'update_status_admin.dart';

// ignore: must_be_immutable
class NotisPage extends StatelessWidget {

    //final user = FirebaseAuth.instance.currentUser!;
     List<ChildAllowaneModel> orders = List.empty();
     /// childAllowanceController controller = childAllowanceController(FirebaseServices());
Stream<List<ChildAllowaneModel>> adminstatus() => FirebaseFirestore.instance
    .collection('ChildAllowance')
    //.where('email',isEqualTo: user.email.toString())

        .snapshots().map((snapshot) => snapshot.docs.map((doc) => ChildAllowaneModel.fromJson(doc.data())).toList());
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดการสถานะ'),
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


      body: StreamBuilder<List<ChildAllowaneModel>>(
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
    Widget buildordersadmin(List<ChildAllowaneModel> orders) => ListView.builder(
    itemCount: !orders.isEmpty ? orders.length : 0,
    itemBuilder: (context, index) {
           if(index >= 0)
      {
 return InkWell(
              //onTap: () { Navigator.push(context,MaterialPageRoute(builder: (context) => UpdateStatusAdminPage(order: orders[index])));},

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
                
                      ],
                    ),
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                              'จำนวนเงิน ${childallowances[index].savedate}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                        Text(
                              childallowances[index].maritalstatus,
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
                                'สถานะการ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        Text(
                              childallowances[index].status,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                         
                      ],
                    ),
*/
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
*/
