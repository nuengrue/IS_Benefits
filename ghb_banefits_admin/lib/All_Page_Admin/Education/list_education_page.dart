//import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Education_Controller.dart';
import 'package:ghb_banefits_admin/All_Models_Admin/education_model.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/detail_education.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';

import 'package:provider/provider.dart';

//import 'package:flutter/widgets.dart';

class ListEducationAdminPage extends StatefulWidget {
  @override
  State<ListEducationAdminPage> createState() => _ListEducationAdminPageState();
}

class _ListEducationAdminPageState extends State<ListEducationAdminPage> {
  List<EducationAdmin> educations = List.empty();
  bool isloading = false;
  late int count;

  EducationAdminController controller =
      EducationAdminController(FirebaseServicesAdmin());

  void initState() {
    super.initState();
    _getEducationAdmin(context);
  }

  void _getEducationAdmin(BuildContext context) async {
    var newEducation = await controller.fetchEducationAdmin();

    context.read<EducationAdminProviders>().EducationAdminList = newEducation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายการคำขอช่วยเหลือการศึกษา',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: iOrangeColor,
          ),
        ),
        backgroundColor: iBlueColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            // tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MainHomeAdminPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<EducationAdminProviders>(
          builder: (context, EducationAdminProviders data, child) {
            // return data.getChildAllowane.length !=0 ? ListView.builder(
            return data.EducationAdminList.length != 0
                ? ListView.builder(
                    itemCount: data.EducationAdminList.length,
                    itemBuilder: (context, index) {
                      return CardList(data.EducationAdminList[index], index);
                    },
                  )
                : GestureDetector(
                    onTap: () {
                      //  Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => AddEduPage()));
                    },
                    child: Center(
                        child: Text(
                      "ไม่พบรายการคำขอ",
                      style: TextStyle(
                        color: iBlueColor,
                      ),
                    )));
          },
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class CardList extends StatelessWidget {
  final EducationAdmin notes;
  int index;
  CardList(this.notes, this.index);
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
            )),
        child: ListTile(
          leading: Icon(Icons.note),
          title: Text(notes.no),
          subtitle: Text(notes.status),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black26,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailEducationAdminPage(Notes: notes, Indexs: index)));
          },
        ),
      ),
    );
  }
}
