import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Education_Controller.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/House_controllers.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/Medical_Controller.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/cremation_service_controllers.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Child_Allowances/list_child_allowance_where.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Cremation_Service/list_cremation_service.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Education/list_education_page.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/House_Allowance/list_house_allowance.dart';
import 'package:ghb_banefits_admin/All_Page_Admin/Medical/list_medical_page.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_cremation.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_education.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_house.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_medical.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/Dashborad/list_Reports.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:ghb_banefits_admin/my_drawer.dart';
import 'package:provider/provider.dart';

class AllDashboradPage extends StatefulWidget {
  @override
  State<AllDashboradPage> createState() => _AllDashboradPageState();
}

class _AllDashboradPageState extends State<AllDashboradPage> {
  @override

    ChildAllowanceAdminController ChildAllowanceAdmincontroller =
      ChildAllowanceAdminController(FirebaseServicesAdmin());

        CremationServiceAdminController CremationServiceAdmincontroller =
      CremationServiceAdminController(FirebaseServicesAdmin());
      
        EducationAdminController EducationAdmincontroller =
      EducationAdminController(FirebaseServicesAdmin());


  HouseAllowanceAdminController HouseAllowanceAdmincontroller =
      HouseAllowanceAdminController(FirebaseServicesAdmin());      

        MedicalAdminController controllerMedicalAdmin =
      MedicalAdminController(FirebaseServicesAdmin());

  void initState() {
    super.initState();
    _getChildAllowanceAdmin(context);
  }

  void _getChildAllowanceAdmin(BuildContext context) async {
    var newChildAllowanceAdmin = await ChildAllowanceAdmincontroller.fetchChildAllowanceAdmin();

    context.read<ChildAllowanceAdminProviders>().ChildAllowanceAdminList =
        newChildAllowanceAdmin;
    // count All Status
    var cAllChildAllowanceAdmin = newChildAllowanceAdmin;
    int vAllChildAllowanceAdmin = cAllChildAllowanceAdmin.length;
    context
        .read<ChildAllowanceAdminProviders>()
        .fliecountAllChildAllowanceAdmin = vAllChildAllowanceAdmin;
    // count  Status Request
    var cRequestChildAllowanceAdmin = newChildAllowanceAdmin.where((x) => x.status == "ร้องขอ");
    int vRequestChildAllowanceAdmin = cRequestChildAllowanceAdmin.length;
    context
        .read<ChildAllowanceAdminProviders>()
        .fliecountRequestChildAllowanceAdmin = vRequestChildAllowanceAdmin;
    // count  Status Approve
    var cApproveChildAllowanceAdmin = newChildAllowanceAdmin.where((x) => x.status == "อนุมัติ");
    var chitChildAllowanceAdmin = cApproveChildAllowanceAdmin;
    // print(chit);
    int vApproveChildAllowanceAdmin = cApproveChildAllowanceAdmin.length;
    context
        .read<ChildAllowanceAdminProviders>()
        .fliecountApproveChildAllowanceAdmin = vApproveChildAllowanceAdmin;

    // count  Status Reject
    var cRejectChildAllowanceAdmin = newChildAllowanceAdmin.where((x) => x.status == "ปฏิเสธ");
    int vRejectChildAllowanceAdmin = cRejectChildAllowanceAdmin.length;
    context
        .read<ChildAllowanceAdminProviders>()
        .fliecountRejectChildAllowanceAdmin = vRejectChildAllowanceAdmin;
//// CremationServiceAdmin
///
            var newCremationServiceAdmin = await CremationServiceAdmincontroller.fetchCremationServiceAdmin();
            context.read<CremationServiceAdminProviders>().CremationServiceAdminList = newCremationServiceAdmin;
            // count All Status
            var cAllCremationServiceAdmin = newCremationServiceAdmin;
            int vAllCremationServiceAdmin = cAllCremationServiceAdmin.length;
            context.read<CremationServiceAdminProviders>().fliecountAllCremationServiceAdmin = vAllCremationServiceAdmin;
            // count  Status Request
            var cRequestCremationServiceAdmin = newCremationServiceAdmin.where((x) => x.status == "ร้องขอ");
            int vRequestCremationServiceAdmin = cRequestCremationServiceAdmin.length;
            context.read<CremationServiceAdminProviders>().fliecountRequestCremationServiceAdmin = vRequestCremationServiceAdmin;
            // count  Status Approve
            var cApproveCremationServiceAdmin = newCremationServiceAdmin.where((x) => x.status == "อนุมัติ");
            int vApproveCremationServiceAdmin = cApproveCremationServiceAdmin.length;
            context.read<CremationServiceAdminProviders>().fliecountApproveCremationServiceAdmin = vApproveCremationServiceAdmin;

             // count  Status Reject
            var cRejectCremationServiceAdmin = newCremationServiceAdmin.where((x) => x.status == "ปฏิเสธ");
            int vRejectCremationServiceAdmin = cRejectCremationServiceAdmin.length;
            context.read<CremationServiceAdminProviders>().fliecountRejectCremationServiceAdmin = vRejectCremationServiceAdmin;   
///EducationAdmin
///
 var newEducationAdmin = await EducationAdmincontroller.fetchEducationAdmin();

          context.read<EducationAdminProviders>().EducationAdminList = newEducationAdmin;
            // count All Status
            var cAllEducationAdmin = newEducationAdmin;
            int vAllEducationAdmin = cAllEducationAdmin.length;
            context.read<EducationAdminProviders>().fliecountAllEducationAdmin = vAllEducationAdmin;
            // count  Status Request
            var cRequestEducationAdmin = newEducationAdmin.where((x) => x.status == "ร้องขอ");
            int vRequestEducationAdmin = cRequestEducationAdmin.length;
            context.read<EducationAdminProviders>().fliecountRequestEducationAdmin = vRequestEducationAdmin;
            // count  Status Approve
            var cApproveEducationAdmin = newEducationAdmin.where((x) => x.status == "อนุมัติ");
            int vApproveEducationAdmin = cApproveEducationAdmin.length;
            context.read<EducationAdminProviders>().fliecountApproveEducationAdmin = vApproveEducationAdmin;

             // count  Status Reject
            var cRejectEducationAdmin = newEducationAdmin.where((x) => x.status == "ปฏิเสธ");
            int vRejectEducationAdmin = cRejectEducationAdmin.length;
            context.read<EducationAdminProviders>().fliecountRejectEducationAdmin = vRejectEducationAdmin;  
///
///HouseAllowanceAdmin
         var newHouseAllowanceAdmin = await HouseAllowanceAdmincontroller.fetchHouseAllowanceAdmin();

          context.read<HouseAllowanceAdminProviders>().HouseAllowanceAdminList = newHouseAllowanceAdmin;
            // count All Status
            var cAllHouseAllowanceAdmin = newHouseAllowanceAdmin;
            int vAllHouseAllowanceAdmin = cAllHouseAllowanceAdmin.length;
            context.read<HouseAllowanceAdminProviders>().fliecountAllHouseAllowanceAdmin = vAllHouseAllowanceAdmin;
            // count  Status Request
            var cRequestHouseAllowanceAdmin = newHouseAllowanceAdmin.where((x) => x.status == "ร้องขอ");
            int vRequestHouseAllowanceAdmin = cRequestHouseAllowanceAdmin.length;
            context.read<HouseAllowanceAdminProviders>().fliecountRequestHouseAllowanceAdmin = vRequestHouseAllowanceAdmin;
            // count  Status Approve
            var cApproveHouseAllowanceAdmin = newHouseAllowanceAdmin.where((x) => x.status == "อนุมัติ");
            int vApproveHouseAllowanceAdmin = cApproveHouseAllowanceAdmin.length;
            context.read<HouseAllowanceAdminProviders>().fliecountApproveHouseAllowanceAdmin = vApproveHouseAllowanceAdmin;

             // count  Status Reject
            var cRejectHouseAllowanceAdmin = newHouseAllowanceAdmin.where((x) => x.status == "ปฏิเสธ");
            int vRejectHouseAllowanceAdmin = cRejectHouseAllowanceAdmin.length;
            context.read<HouseAllowanceAdminProviders>().fliecountRejectHouseAllowanceAdmin = vRejectHouseAllowanceAdmin;           

///
///
           var newMedicalAdmin = await controllerMedicalAdmin.fetchMedicalAdmin();

          context.read<MedicalAdminProviders>().MedicalAdminList = newMedicalAdmin;
            // count All Status
            var cAllMedicalAdmin = newMedicalAdmin;
            int vAllMedicalAdmin = cAllMedicalAdmin.length;
            context.read<MedicalAdminProviders>().fliecountAllMedicalAdmin = vAllMedicalAdmin;
            // count  Status Request
            var cRequestMedicalAdmin = newMedicalAdmin.where((x) => x.status == "ร้องขอ");
            int vRequestMedicalAdmin = cRequestMedicalAdmin.length;
            context.read<MedicalAdminProviders>().fliecountRequestMedicalAdmin = vRequestMedicalAdmin;
            // count  Status Approve
            var cApproveMedicalAdmin = newMedicalAdmin.where((x) => x.status == "อนุมัติ");
            int vApproveMedicalAdmin = cApproveMedicalAdmin.length;
            context.read<MedicalAdminProviders>().fliecountApproveMedicalAdmin = vApproveMedicalAdmin;

             // count  Status Reject
            var cRejectMedicalAdmin = newMedicalAdmin.where((x) => x.status == "ปฏิเสธ");
            int vRejectMedicalAdmin = cRejectMedicalAdmin.length;
            context.read<MedicalAdminProviders>().fliecountRejectMedicalAdmin = vRejectMedicalAdmin;           

///
///
  }

   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard รายการอนุมัติสวัสดิการ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
            color: iWhiteColor,),),backgroundColor: iOrangeColor,
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
body: SingleChildScrollView(
  child: Column(children: <Widget>[
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
              elevation: 0,
              color: iWhiteColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: iBlueColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
            child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
                  "ภาพรวมรายการค่าช่วยเหลือค่ารักษาพยาบาล",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    color: iBlueColor,
                  ),
                ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iAllColor,
                      title: Text('จำนวนรายการทั้งหมด : ' + context.watch<MedicalAdminProviders>().fliecountAllMedicalAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListMedicalAdminPage(Status:"Total All"))); },
),                      
                    ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRequestColor,
                      title: Text('จำนวนรายการร้องขอ : ' + context.watch<MedicalAdminProviders>().fliecountRequestMedicalAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListMedicalAdminPage(Status:"ร้องขอ"))); },
),                      
                    ),
    ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iApproveColor,
                      title: Text('จำนวนรายการอนุมัติ : ' + context.watch<MedicalAdminProviders>().fliecountApproveMedicalAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListMedicalAdminPage(Status:"อนุมัติ"))); },
),                      
                    ),
    ),
 Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRejectColor,
                      title: Text('จำนวนรายการปฏิเสธ : ' + context.watch<MedicalAdminProviders>().fliecountRejectMedicalAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListMedicalAdminPage(Status:"ปฏิเสธ"))); },
),                      
                    ),
    ),
  ],
),
        ),
      ),
    ),
//--
 

    //---



  ],
),
         ),
 
       Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
   
//--
  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
              elevation: 0,
              color: iWhiteColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: iBlueColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
            child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
                  "ภาพรวมรายการค่าช่วยเหลือการศึกษาบุตร",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    color: iBlueColor,
                  ),
                ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iAllColor,
                      title: Text('จำนวนรายการทั้งหมด : ' + context.watch<EducationAdminProviders>().fliecountAllEducationAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListEducationAdminPage(Status:"Total All"))); },
),                      
                    ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRequestColor,
                      title: Text('จำนวนรายการร้องขอ : ' + context.watch<EducationAdminProviders>().fliecountRequestEducationAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListEducationAdminPage(Status:"ร้องขอ"))); },
),                      
                    ),
    ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iApproveColor,
                      title: Text('จำนวนรายการอนุมัติ : ' + context.watch<EducationAdminProviders>().fliecountApproveEducationAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListEducationAdminPage(Status:"อนุมัติ"))); },
),                      
                    ),
    ),
 Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRejectColor,
                      title: Text('จำนวนรายการปฏิเสธ : ' + context.watch<EducationAdminProviders>().fliecountRejectEducationAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListEducationAdminPage(Status:"ปฏิเสธ"))); },
),                      
                    ),
    ),
  ],
),
        ),
      ),
    ),

    //---
    //--


  ],
),
         ),
 
 ///
      Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  
    //---
      Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
              elevation: 0,
              color: iWhiteColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: iBlueColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
            child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
                  "ภาพรวมรายการเงินช่วยเหลือบุตร",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    color: iBlueColor,
                  ),
                ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iAllColor,
                      title: Text('จำนวนรายการทั้งหมด : ' + context.watch<ChildAllowanceAdminProviders>().fliecountAllChildAllowanceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListChildAllowanceAdminPage(Status:"Total All"))); },
),                      
                    ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRequestColor,
                      title: Text('จำนวนรายการร้องขอ : ' + context.watch<ChildAllowanceAdminProviders>().fliecountRequestChildAllowanceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListChildAllowanceAdminPage(Status:"ร้องขอ"))); },
),                      
                    ),
    ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iApproveColor,
                      title: Text('จำนวนรายการอนุมัติ : ' + context.watch<ChildAllowanceAdminProviders>().fliecountApproveChildAllowanceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListChildAllowanceAdminPage(Status:"อนุมัติ"))); },
),                      
                    ),
    ),
 Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRejectColor,
                      title: Text('จำนวนรายการปฏิเสธ : ' + context.watch<ChildAllowanceAdminProviders>().fliecountRejectChildAllowanceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListChildAllowanceAdminPage(Status:"ปฏิเสธ"))); },
),                      
                    ),
    ),
  ],
),
        ),
      ),
    ),
    //--


  ],
),
         ),
 ///
 ///
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
              elevation: 0,
              color:iWhiteColor ,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: iBlueColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
            child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
                  "ภาพรวมรายการค่าเช่าบ้านสำหรับพนักงาน",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    color: iBlueColor,
                  ),
                ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iAllColor,
                      title: Text('จำนวนรายการทั้งหมด : ' + context.watch<HouseAllowanceAdminProviders>().fliecountAllHouseAllowanceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListHouseAllowanceAdminPage(Status:"Total All"))); },
),                      
                    ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRequestColor,
                      title: Text('จำนวนรายการร้องขอ : ' + context.watch<HouseAllowanceAdminProviders>().fliecountRequestHouseAllowanceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListHouseAllowanceAdminPage(Status:"ร้องขอ"))); },
),                      
                    ),
    ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iApproveColor,
                      title: Text('จำนวนรายการอนุมัติ : ' + context.watch<HouseAllowanceAdminProviders>().fliecountApproveHouseAllowanceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListHouseAllowanceAdminPage(Status:"อนุมัติ"))); },
),                      
                    ),
    ),
 Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRejectColor,
                      title: Text('จำนวนรายการปฏิเสธ : ' + context.watch<HouseAllowanceAdminProviders>().fliecountRejectHouseAllowanceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListHouseAllowanceAdminPage(Status:"ปฏิเสธ"))); },
),                      
                    ),
    ),
  ],
),
        ),
      ),
    ),
//--

    //---

    //--


  ],
),
          ),
 ///
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
//--
  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
              elevation: 0,
              color: iWhiteColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: iBlueColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
            child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
                  "ภาพรวมรายการสมัครฌาปนกิจ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,fontFamily: 'Sarabun',
                    color: iBlueColor,
                  ),
                ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iAllColor,
                      title: Text('จำนวนรายการทั้งหมด : ' + context.watch<CremationServiceAdminProviders>().fliecountAllCremationServiceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListCremationServiceAdminPage(Status:"Total All"))); },
),                      
                    ),
    ),
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRequestColor,
                      title: Text('จำนวนรายการร้องขอ : ' + context.watch<CremationServiceAdminProviders>().fliecountRequestCremationServiceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListCremationServiceAdminPage(Status:"ร้องขอ"))); },
),                      
                    ),
    ),
  Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iApproveColor,
                      title: Text('จำนวนรายการอนุมัติ : ' + context.watch<CremationServiceAdminProviders>().fliecountApproveCremationServiceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListCremationServiceAdminPage(Status:"อนุมัติ"))); },
),                      
                    ),
    ),
 Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        tileColor: iRejectColor,
                      title: Text('จำนวนรายการปฏิเสธ : ' + context.watch<CremationServiceAdminProviders>().fliecountRejectCremationServiceAdmin.toString(),style: TextStyle(fontFamily: 'Sarabun',),),
                                trailing:  IconButton(
                                  icon:  Icon(Icons.visibility),
                                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListCremationServiceAdminPage(Status:"ปฏิเสธ"))); },
),                      
                    ),
    ),
  ],
),
        ),
      ),
    ),

    //---

    //--


  ],
),
          ),
  ],
          
        ),
),
    );
   }
}
//       body: SingleChildScrollView(
//         child: Column(children: <Widget>[
//           SizedBox(height: 12),
//           Card(
//             child: <Widget>[
//              Padding(
//               padding: const EdgeInsets.all(5.0),
//                child: const Text(
//                 "ภาพรวมรายการค่าช่วยเหลือค่ารักษาพยาบาล",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: iBlueColor,
//                 ),
//               ),
//               child: const ListTile(
//               leading: Icon(Icons.album),
//               title: Text('The Enchanted Nightingale'),
//               subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 TextButton(
//                   child: const Text('BUY TICKETS'),
//                   onPressed: () {/* ... */},
//                 ),
//                 const SizedBox(width: 8),
//                 TextButton(
//                   child: const Text('LISTEN'),
//                   onPressed: () {/* ... */},
//                 ),
//                 const SizedBox(width: 8),
//               ],
//             ),
//           ],
//             ),
//         ],
//           ),
          
      
//           SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                   Column(
//                   children: [
//                     // Text(
//                     //   'Total All',
//                     //   style: TextStyle(
//                     //     fontSize: 20,
//                     //     fontWeight: FontWeight.bold,
//                     //     color: iBlueColor,
//                     //   ),
//                     // ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"Total All")));
//                       },
//                       child: Container(
//                         height: 50,
//                         width: 300,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iAllColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text('ทั้งหมด :  '+
//                             context.watch<MedicalAdminProviders>().fliecountAllMedicalAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                   Column(
//                   children: [
//                     Text(
//                       'Request',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"ร้องขอ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRequestColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<MedicalAdminProviders>().fliecountRequestMedicalAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                  Column(
//                   children: [
//                     Text(
//                       'Approve',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"อนุมัติ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iApproveColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<MedicalAdminProviders>().fliecountApproveMedicalAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                      Column(
//                   children: [
//                     Text(
//                       'Reject',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage( Status:"ปฏิเสธ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRejectColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<MedicalAdminProviders>().fliecountRejectMedicalAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(10.0),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           //     children: [
//           //            Column(
//           //         children: [
//           //           Text(
//           //             'Approve',
//           //             style: TextStyle(
//           //               fontSize: 20,
//           //               fontWeight: FontWeight.bold,
//           //               color: iBlueColor,
//           //             ),
//           //           ),
//           //           SizedBox(height: 12),
//           //           InkWell(
//           //             onTap: () {
//           //               Navigator.of(context).push(MaterialPageRoute(
//           //                   builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"อนุมัติ")));
//           //             },
//           //             child: Container(
//           //               height: 80,
//           //               width: 150,
//           //               padding: EdgeInsets.all(20),
//           //               decoration: BoxDecoration(
//           //                 color: iApproveColor,
//           //                 borderRadius: BorderRadius.circular(20),
//           //                 boxShadow: [
//           //                   BoxShadow(
//           //                     color: Colors.black54,
//           //                     blurRadius: 6.0,
//           //                     spreadRadius: 2.0,
//           //                   ),
//           //                 ],
//           //               ),
//           //               child: Center(
//           //                 child: Text(
//           //                   context.watch<MedicalAdminProviders>().fliecountApproveMedicalAdmin.toString(),
//           //                   style: TextStyle(
//           //                     fontSize: 25,
//           //                     fontWeight: FontWeight.bold,
//           //                     color: iBlackColor,
//           //                   ),
//           //                 ),
//           //               ),
//           //             ),
//           //           ),
//           //         ],
//           //       ),
//           //            Column(
//           //         children: [
//           //           Text(
//           //             'Reject',
//           //             style: TextStyle(
//           //               fontSize: 20,
//           //               fontWeight: FontWeight.bold,
//           //               color: iBlueColor,
//           //             ),
//           //           ),
//           //           SizedBox(height: 12),
//           //           InkWell(
//           //             onTap: () {
//           //               Navigator.of(context).push(MaterialPageRoute(
//           //                   builder: (context) => const ListChildAllowanceWhereAdminPage( Status:"ปฏิเสธ")));
//           //             },
//           //             child: Container(
//           //               height: 80,
//           //               width: 150,
//           //               padding: EdgeInsets.all(20),
//           //               decoration: BoxDecoration(
//           //                 color: iRejectColor,
//           //                 borderRadius: BorderRadius.circular(20),
//           //                 boxShadow: [
//           //                   BoxShadow(
//           //                     color: Colors.black54,
//           //                     blurRadius: 6.0,
//           //                     spreadRadius: 2.0,
//           //                   ),
//           //                 ],
//           //               ),
//           //               child: Center(
//           //                 child: Text(
//           //                   context.watch<MedicalAdminProviders>().fliecountRejectMedicalAdmin.toString(),
//           //                   style: TextStyle(
//           //                     fontSize: 25,
//           //                     fontWeight: FontWeight.bold,
//           //                     color: iBlackColor,
//           //                   ),
//           //                 ),
//           //                 //Image.asset(iconImagePath),
//           //               ),
//           //             ),
//           //           ),
//           //         ],
//           //       ),             
             
             
//           //     ],
//           //   ),
//           // ),
//         ///
//         ///
//             SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Text(
//               "ภาพรวมรายการค่าช่วยเหลือการศึกษาบุตร",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: iBlueColor,
//               ),
//             ),
//           ),
//           SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                   Column(
//                   children: [
//                     Text(
//                       'Total All',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"Total All")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iAllColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<EducationAdminProviders>().fliecountAllEducationAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                   Column(
//                   children: [
//                     Text(
//                       'Request',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"ร้องขอ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRequestColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<EducationAdminProviders>().fliecountRequestEducationAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                      Column(
//                   children: [
//                     Text(
//                       'Approve',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"อนุมัติ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iApproveColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<EducationAdminProviders>().fliecountApproveEducationAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                      Column(
//                   children: [
//                     Text(
//                       'Reject',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage( Status:"ปฏิเสธ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRejectColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<EducationAdminProviders>().fliecountRejectEducationAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),             
             
             
//               ],
//             ),
//           ),      
//  ////
//             SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Text(
//               "ภาพรวมรายการเงินช่วยเหลือบุตร",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: iBlueColor,
//               ),
//             ),
//           ),
//           SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                   Column(
//                   children: [
//                     Text(
//                       'Total All',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"Total All")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iAllColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context
//                         .watch<ChildAllowanceAdminProviders>()
//                         .fliecountAllChildAllowanceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                   Column(
//                   children: [
//                     Text(
//                       'Request',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"ร้องขอ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRequestColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context
//                                 .watch<ChildAllowanceAdminProviders>()
//                                 .fliecountRequestChildAllowanceAdmin
//                                 .toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                      Column(
//                   children: [
//                     Text(
//                       'Approve',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"อนุมัติ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iApproveColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context
//                         .watch<ChildAllowanceAdminProviders>()
//                         .fliecountApproveChildAllowanceAdmin
//                                 .toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                      Column(
//                   children: [
//                     Text(
//                       'Reject',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage( Status:"ปฏิเสธ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRejectColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context
//                         .watch<ChildAllowanceAdminProviders>()
//                         .fliecountRejectChildAllowanceAdmin
//                                 .toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),             
             
             
//               ],
//             ),
//           ),      
//  ///
//             SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Text(
//               "ภาพรวมรายการค่าเช่าบ้านสำหรับพนักงาน",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: iBlueColor,
//               ),
//             ),
//           ),
//           SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                   Column(
//                   children: [
//                     Text(
//                       'Total All',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"Total All")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iAllColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<HouseAllowanceAdminProviders>().fliecountAllHouseAllowanceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                   Column(
//                   children: [
//                     Text(
//                       'Request',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"ร้องขอ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRequestColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<HouseAllowanceAdminProviders>().fliecountRequestHouseAllowanceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                      Column(
//                   children: [
//                     Text(
//                       'Approve',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"อนุมัติ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iApproveColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<HouseAllowanceAdminProviders>().fliecountApproveHouseAllowanceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                      Column(
//                   children: [
//                     Text(
//                       'Reject',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage( Status:"ปฏิเสธ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRejectColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<HouseAllowanceAdminProviders>().fliecountRejectHouseAllowanceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),             
             
             
//               ],
//             ),
//           ),      
//     //////
//     ///  
//         SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Text(
//               "ภาพรวมรายการสมัครฌาปนกิจ",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: iBlueColor,
//               ),
//             ),
//           ),
//           SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                   Column(
//                   children: [
//                     Text(
//                       'Total All',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"Total All")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iAllColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<CremationServiceAdminProviders>().fliecountAllCremationServiceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                   Column(
//                   children: [
//                     Text(
//                       'Request',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"ร้องขอ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRequestColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<CremationServiceAdminProviders>().fliecountRequestCremationServiceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                      Column(
//                   children: [
//                     Text(
//                       'Approve',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage(Status:"อนุมัติ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iApproveColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<CremationServiceAdminProviders>().fliecountApproveCremationServiceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                      Column(
//                   children: [
//                     Text(
//                       'Reject',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: iBlueColor,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const ListChildAllowanceWhereAdminPage( Status:"ปฏิเสธ")));
//                       },
//                       child: Container(
//                         height: 80,
//                         width: 150,
//                         padding: EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: iRejectColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black54,
//                               blurRadius: 6.0,
//                               spreadRadius: 2.0,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             context.watch<CremationServiceAdminProviders>().fliecountRejectCremationServiceAdmin.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: iBlackColor,
//                             ),
//                           ),
//                           //Image.asset(iconImagePath),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),             
             
             
//               ],
//             ),
//           ),             
//                     SizedBox(height: 12),
//         ]),
        
//       ),

//       //drawer: const MyDrawer(),
//     );
//   }
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text(
//   //         'Dashboard รายการอนุมัติสวัสดิการ',
//   //         textAlign: TextAlign.center,
//   //         style: TextStyle(
//   //           fontSize: 28,
//   //           fontWeight: FontWeight.bold,
//   //           color: iOrangeColor,
//   //         ),
//   //       ),
//   //       backgroundColor: iBlueColor,
//   //                    actions: <Widget>[
//   //         IconButton(
//   //           icon: const Icon(Icons.home),
//   //           // tooltip: 'Show Snackbar',
//   //           onPressed: () {

//   //             Navigator.of(context).push(
//   //                 MaterialPageRoute(builder: (context) => MainHomeAdminPage()));
//   //           },
//   //         ),
//   //       ],),
//   //     body: SingleChildScrollView(
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           //SizedBox(height: 10),

//   //           //buttons
//   //           Padding(
//   //             padding: const EdgeInsets.all(5.0),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 ListDashborad(
//   //                   buttonText: 'ภาพรวมรายการค่าช่วยเหลือค่ารักษาพยาบาล',
//   //                   index: '/8',
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           // SizedBox(height: 10),
//   //           //buttons
//   //           Padding(
//   //             padding: const EdgeInsets.all(5.0),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 ListDashborad(
//   //                   buttonText: 'ภาพรวมรายการค่าช่วยเหลือการศึกษาบุตร',
//   //                   index: '/9',
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           // SizedBox(height: 10),
//   //           //buttons
//   //           Padding(
//   //             padding: const EdgeInsets.all(5.0),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 ListDashborad(
//   //                   buttonText: 'ภาพรวมรายการเงินช่วยเหลือบุตร',
//   //                   index: '/10',
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           // SizedBox(height: 10),
//   //           //buttons
//   //           Padding(
//   //             padding: const EdgeInsets.all(5.0),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 ListDashborad(
//   //                   buttonText: 'ภาพรวมรายการค่าเช่าบ้านสำหรับพนักงาน',
//   //                   index: '/11',
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           // SizedBox(height: 10),
//   //           //buttons
//   //           Padding(
//   //             padding: const EdgeInsets.all(5.0),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               children: [
//   //                 ListDashborad(
//   //                   buttonText: 'ภาพรวมรายการฌาปนกิจสงเคราะห์',
//   //                   index: '/12',
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //     //drawer: MyDrawer(),
//   //   );
//   // }
// }