import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/All_Controllers_Admin/child_allowance_controllers.dart';
import 'package:ghb_banefits_admin/All_Providers_Admin/provider_child_allowance.dart';
import 'package:ghb_banefits_admin/All_Services_Admin/servics.dart';
import 'package:ghb_banefits_admin/Dashborad/boxdashborad.dart';
import 'package:ghb_banefits_admin/color.dart';
import 'package:ghb_banefits_admin/main_home_admin_page.dart';
import 'package:provider/provider.dart';


class ChildAllowancesDashboradPage extends StatefulWidget {
  @override
  State<ChildAllowancesDashboradPage> createState() => _ChildAllowancesDashboradPageState();
}

class _ChildAllowancesDashboradPageState extends State<ChildAllowancesDashboradPage> {


  ChildAllowanceAdminController controller =
      ChildAllowanceAdminController(FirebaseServicesAdmin());
      

      void initState() {
        super.initState();
        _getChildAllowanceAdmin(context);
      }

   void   _getChildAllowanceAdmin(BuildContext context) async {
            var newChildAllowanceAdmin = await controller.fetchChildAllowanceAdmin();

          context.read<ChildAllowanceAdminProviders>().ChildAllowanceAdminList = newChildAllowanceAdmin;
            // count All Status
            var cAll = newChildAllowanceAdmin;
            int vAll = cAll.length;
            context.read<ChildAllowanceAdminProviders>().fliecountAllChildAllowanceAdmin = vAll;
            // count  Status Request
            var cRequest = newChildAllowanceAdmin.where((x) => x.status == "Request");
            int vRequest = cRequest.length;
            context.read<ChildAllowanceAdminProviders>().fliecountRequestChildAllowanceAdmin = vRequest;
            // count  Status Approve
            var cApprove = newChildAllowanceAdmin.where((x) => x.status == "Approve");
            int vApprove = cApprove.length;
            context.read<ChildAllowanceAdminProviders>().fliecountApproveChildAllowanceAdmin = vApprove;

             // count  Status Reject
            var cReject = newChildAllowanceAdmin.where((x) => x.status == "Reject");
            int vReject = cReject.length;
            context.read<ChildAllowanceAdminProviders>().fliecountRejectChildAllowanceAdmin = vReject;           

        
      }


  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(title: Text('ภาพรวมรายการค่าช่วยเหลือบุตร',style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: iOrangeColor,
                          ),),
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
        ],),
 
            body: SingleChildScrollView(

              child: Column(
              children: <Widget>[
                            SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ภาพรวมรายการค่าช่วยเหลือบุตร",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: iBlueColor,
            ),
            ),
                ),
                            SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BoxDashborad(
                        countnum: context.watch<ChildAllowanceAdminProviders>().fliecountAllChildAllowanceAdmin,
                        buttonText: 'Total All',
                        indexColor:iAllColor,
                      ),
                      BoxDashborad(
                        countnum: context.watch<ChildAllowanceAdminProviders>().fliecountRequestChildAllowanceAdmin,
                        buttonText: 'Request',
                        indexColor: iRequestColor,
                      ),

                    ],
                  ),
                ),
                                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BoxDashborad(
                        countnum: context.watch<ChildAllowanceAdminProviders>().fliecountApproveChildAllowanceAdmin,
                        buttonText: 'Approve',
                        indexColor:iApproveColor,
                      ),
                      BoxDashborad(
                        countnum: context.watch<ChildAllowanceAdminProviders>().fliecountRejectChildAllowanceAdmin,
                        buttonText: 'Reject',
                        indexColor: iRejectColor,
                      ),

                    ],
                  ),
                ),

              ]
              ),
            ),
     
             //drawer: const MyDrawer(),
      );
  }
}

