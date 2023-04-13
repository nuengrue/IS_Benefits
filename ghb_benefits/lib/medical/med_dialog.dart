import 'package:flutter/material.dart';
import 'package:ghb_benefits/medical/user.dart';


class AddMedDialog extends StatefulWidget {
    final Function(Medtreat) addUser;
      AddMedDialog(this.addUser);
  //const AddMedDialog({Key? key}) : super(key: key);

  @override
  State<AddMedDialog> createState() => _AddMedDialogState();
}

class _AddMedDialogState extends State<AddMedDialog> {



  //_AddMedDialogState(this.addUser);
  @override
  Widget build(BuildContext context) {
    Widget buildTextfield(String hint, TextEditingController controller){
      return Container(
        margin: EdgeInsets.all(4.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: hint,
            border:  OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black38,
              )
            ),
          ),
          controller: controller,
        ),
      );
    }
var medicallistController = TextEditingController();
var numberdaysController = TextEditingController();
var amountController = TextEditingController();
var othernotesController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(8.0),
      height: 350,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('add med',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.blueGrey,


            ),
            ),
            buildTextfield('จำนวนวันรักษา',medicallistController),
            buildTextfield('จำนวนวันรักษา',numberdaysController),
                      buildTextfield('จำนวนวัน',amountController),
                                buildTextfield('หมายเหตุอื่นๆ',othernotesController),
              
              ElevatedButton(onPressed: () {
                final medtreat = Medtreat(medicallistController.text,numberdaysController.text,amountController.text,othernotesController.text);
                widget.addUser(medtreat);
                print(medtreat.medicallist);
                print(medtreat.amount);
                Navigator.of(context).pop();
              }, 
              child: Text('Add med'),)
          ],
        ),
      ),
    );
    
  }
}