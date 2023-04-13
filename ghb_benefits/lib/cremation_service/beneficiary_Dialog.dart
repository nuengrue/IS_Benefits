import 'package:flutter/material.dart';
import 'package:ghb_benefits/color.dart';
import 'package:ghb_benefits/cremation_service/beneficiary.dart';



class AddBeneficiaryDialog extends StatefulWidget {
  final Function(Beneficiary) addBeneficiaryData;
  AddBeneficiaryDialog(this.addBeneficiaryData);
  //const AddBeneficiaryDialog({Key? key}) : super(key: key);

  @override
  State<AddBeneficiaryDialog> createState() => _AddBeneficiaryDialogState();
}

class _AddBeneficiaryDialogState extends State<AddBeneficiaryDialog> {
  //_AddBeneficiaryDialogState(this.addUser);
  @override
  Widget build(BuildContext context) {
    Widget buildTextfield(String hint, TextEditingController controller) {
      return Container(
        margin: EdgeInsets.all(4.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: hint,
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black38,
            )),
          ),
          controller: controller,
        ),
      );
    }
  String id = '';
    var nameController = TextEditingController();
    var housenumberController = TextEditingController();
    var alleyController = TextEditingController();
    var roadController = TextEditingController();
    var districtController = TextEditingController();
    var countyController = TextEditingController();
    var provinceController = TextEditingController();
    var phonenumberController = TextEditingController();
    var relationshipController = TextEditingController();

    return Container(
      padding: EdgeInsets.all(8.0),
      //height: 400,
      //width: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'เพิ่มรายการ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    //fontSize: ,
                    color: iBlueColor,
                  ),
                ),
              ],
            ),
            buildTextfield('ชื่อ-นามสกุล', nameController),
            buildTextfield('ที่อยู่', housenumberController),
            //buildTextfield('ตรอก/ซอย', alleyController),
            //buildTextfield('ถนน', roadController),
            //buildTextfield('ตำบล/แขวง', districtController),
            //buildTextfield('อำเภอ/เขต', countyController),
            //buildTextfield('จังหวัด', provinceController),
            buildTextfield('หมายเลขติดต่อ', phonenumberController),
            buildTextfield('ความเกี่ยวกับพนักงาน', relationshipController),
            ElevatedButton(
              onPressed: () {
                final beneficiary = Beneficiary(
                    nameController.text,
                    housenumberController.text,
                    alleyController.text,
                    roadController.text,
                    districtController.text,
                    countyController.text,
                    provinceController.text,
                    phonenumberController.text,
                    relationshipController.text);
                widget.addBeneficiaryData(beneficiary);
                Navigator.of(context).pop();
              },
              child: Text('บันทึกข้อมูล'),
            )
          ],
        ),
      ),
    );
  }
}
