import 'package:first_app/medical.dart';
import 'package:flutter/material.dart';

class SubDetailMedicalPage extends StatelessWidget {
  final ListdataMedical listdatamedical;

  SubDetailMedicalPage(this.listdatamedical);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listdatamedical.receiptnumber),
      ),
      body: Center(
        child: Table(
          children: [
            TableRow(
              children: [
                Text('ID'),
                Text('Name'),
                Text('Age'),
              ],
            ),
            TableRow(
              children: [
                Text(listdatamedical.receiptnumber),
                Text(listdatamedical.empcode),
                Text(listdatamedical.fname),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
