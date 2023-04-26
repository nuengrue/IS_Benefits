//import 'dart:developer';

import 'package:first_app/medical.dart';
import 'package:first_app/subdetail_medical_page.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class DetailMedicalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('รายการคำขอเบิก'),
        ),
        body: ListView.builder(
            itemCount: ListdataMedicalmodal.length,
            itemBuilder: (context, index) {
              ListdataMedical listdatamedical = ListdataMedicalmodal[index];
              return Card(
                child: ListTile(
                  title: Text(listdatamedical.savedate),
                  subtitle: Text(listdatamedical.receiptnumber),
                  trailing: Icon(Icons.arrow_back_ios_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SubDetailMedicalPage(listdatamedical)));
                  },
                ),
              );
            }));
  }
}
/*
class ItemDetail {
  final String item;
  final int colorShade;
  const ItemDetail(this.item,this.colorShade);
}

*/

/*class ItemDetailPage extends StatelessWidget
{
  const ItemDetailPage ({super.key, required this.detail});
  final ItemDetail  detail;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Ttem Detail'),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Item - ${detail.item}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Item - ${detail.colorShade}'),
          ),

        ],

      ),
    );
  }
}*/