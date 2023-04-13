
/*
import 'package:flutter/material.dart';

import '../medical/med_dialog.dart';
import '../medical/user.dart';



class DynamicPage extends StatefulWidget {
  const DynamicPage({Key? key}) : super(key: key);

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
          List<Medtreat> medtreatList = [];
  @override
  Widget build(BuildContext context) {

        void addMedData(Medtreat medtreat)
    {
      setState(() {
        medtreatList.add(medtreat);



      });
          print(medtreatList);
      //print(medtreatList.map((e) => medtreatList.forEach((element) {medtreat.email.toString();})));
    }
    void ShowUserDialog(){
      showDialog(context: context, builder: (_) {
        return AlertDialog(
          content: AddMedDialog(addMedData),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        );
        
      },
      
      );
    }






    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ShowUserDialog,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Test Add'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: ListView.builder(itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(4),
            elevation: 8,
            child: ListTile(
              title: Text(medtreatList[index].medicallist),
              subtitle: Text(medtreatList[index].numberdays),
              trailing: Text(medtreatList[index].amount),
        

            ),
            
          );
          
        },itemCount: medtreatList.length,
              
        ),
      ),
    );
    
  }
}
*/