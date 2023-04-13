//import 'dart:developer';
/*
import 'package:flutter/material.dart';
import 'package:ghb_benefits/child_allowance/add_child_allowance.dart';
import 'package:ghb_benefits/child_allowance/child_allowane_model.dart';
import 'package:ghb_benefits/child_allowance/detail_child_allowance.dart';
import 'package:ghb_benefits/child_allowance/model.dart';
import 'package:ghb_benefits/child_allowance/provider_child_allowance.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/htttpTest/service.dart';
import 'package:ghb_benefits/my_drawer.dart';
import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class ListChildAllowancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('รายการคำขอเบิกค่าช่วยเหลือบุตร',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
      backgroundColor: iBlueColor,
       actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddChildAllowancePage()));
            },
          ),
        ],),
        /*
body:FutureBuilder<List<ChildAllowaneModel>>(
    future: Service().fetchChildAllowaneModel(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return Container();
      List<ChildAllowaneModel>? cars = snapshot.data;
          
                        return buildordersadmin(cars!);
    },
  ),
  */
            body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ChildAllowaneProviders>(
          builder: (context,ChildAllowaneProviders data,child){
             print(data.getChildAllowane);
           // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.getChildAllowane.length !=0 ? ListView.builder(
              itemCount: data.getChildAllowane.length,
              itemBuilder: (context,index){

                return CardList(data.getChildAllowane[index],index);

                /*Card(
                child: ListTile(
                  title: Text(data.getChildAllowane[index].no),
                  subtitle: Text(data.getChildAllowane[index].status),
                  trailing: Icon(Icons.arrow_circle_right),
                  onTap: () {
                  //  Navigator.push( context,MaterialPageRoute(builder: (context) =>SubListChildAllowancePage(listdatamedical)));
                  },
                ),
              );
                */
                
                

              },
            ): GestureDetector(onTap: (){
               Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddChildAllowancePage()));
            },child: Center(child: Text("ไม่พบรายการคำขอ",style: TextStyle(color: iBlueColor,),)));
          },
        ),
      ),
      
             drawer: MyDrawer(),
      );
  }
  }
/*
   Widget buildordersadmin(List<ChildAllowaneModel> orders) => ListView.builder(
    itemCount: !orders.isEmpty ? orders.length : 0,
    itemBuilder: (context, index) {
           if(index >= 0)
      {
 return InkWell(
             onTap: () { Navigator.push(context,MaterialPageRoute
            (builder: (context) => DetailChildAllowancePage(Notes: orders[index])));},

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
                              ' ${orders[index].on}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                        Text(
                              orders[index].department,
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

 class CardList extends StatelessWidget {
  final ChildAllowaneModel notes;
  int index;
  CardList(this.notes,this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
          ),
          child: ListTile(
           leading: Icon(Icons.note),
            title: Text(notes.empcode),
            subtitle: Text(notes.status),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black26,),
             onTap: () {
                  Navigator.push( context,MaterialPageRoute(builder: (context) =>DetailChildAllowancePage(Notes : notes)));
                  },
          ),
        ),
    );
  }
}
*/
