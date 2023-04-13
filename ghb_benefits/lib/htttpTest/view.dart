/*

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ghb_benefits/htttpTest/d_view.dart';
import 'package:ghb_benefits/htttpTest/post_modal.dart';
import 'package:ghb_benefits/htttpTest/service.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  List<Post>? posts;
  var isLoaded = false;
   List<Post>? datas;

    @override
    void initState() {
    super.initState();
//fetch data
getData();

  }

  getData() async {
    posts = await Service().getPosts();
    if(posts != null)
    {
      setState(() {
        isLoaded = true;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts'),),
      
       
        body :
        //Text("kk"),
        FutureBuilder<List<Post>>(
    future: Service().fetchPosts(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Container();
      List<Post>? cars = snapshot.data;
          
                        return buildordersadmin(cars!);
    },
  ),

    );

  }

   Widget buildordersadmin(List<Post> orders) => ListView.builder(
    itemCount: !orders.isEmpty ? orders.length : 0,
    itemBuilder: (context, index) {
           if(index >= 0)
      {
 return InkWell(
             onTap: () { Navigator.push(context,MaterialPageRoute
            (builder: (context) => UpdateStatusAdminPage(order: orders[index])));},

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
                              'จำนวนเงิน ${orders[index].id}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                        Text(
                              orders[index].Doc,
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

 
*/

