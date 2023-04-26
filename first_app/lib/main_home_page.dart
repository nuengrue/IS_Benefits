import 'package:first_app/add_medical_page.dart';
import 'package:first_app/medical_page.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MainHomePage extends StatefulWidget {
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(bottom: 50.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                //color: Colors.grey,
                color: Colors.white.withOpacity(0.50),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //borderRadius: const BorderRadius.all(Redius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "ค่ารักษาพยาบาล", //
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              //color:
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  //
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value: 80,
                                    showTitle: false,
                                    radius: 25,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 20,
                                    showTitle: false,
                                    radius: 25,
                                  ),
                                ], //
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'เงินที่ใช้ได้',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '32,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'เงินที่ใช้ไป',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '8,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'วงเงินตามสิทธิ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(''),
                                    const Text(
                                      '40,000',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            /*  onPressed: () => Navigator.pushNamed(context, '/2'),*/
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MedicalPage()));
                            },
                            child: const Text('ยื่นคำขอเบิกค่ารักษาพยาบาล'),
                          ),
                        ], //
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///
            Padding(
              padding: const EdgeInsets.all(5.0),
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.only(bottom: 100.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                //color: Colors.grey,
                color: Colors.white.withOpacity(0.50),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //borderRadius: const BorderRadius.all(Redius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "ค่าช่วยเหลือการศึกษาบุตร", //
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              //color:
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  //
                                  PieChartSectionData(
                                      color: Colors.blue, value: 80),
                                  PieChartSectionData(value: 20),
                                ], //
                              ),
                            ),
                          ),
                          Text(
                            ' ยอดเงินที่ใช้ได้ 32,000 บาท',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 9, 28, 235),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('จากยอดวงเงินตามสิทธิ  40,000 บาท'),
                          Text('ใช้ไปแล้ว'),
                          Text('20.00 %'),
                          Text('จำนวนเงิน 8,000 บาท'),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                                'ยื่นคำขอเบิกค่าช่วยเหลือการศึกษาบุตร'),
                          ),
                        ], //
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* class AddMedPage extends StatefulWidget {
  const AddMedPage({Key? key}) : super(key: key);

  @override
  State<AddMedPage> createState() => _AddMedPageState();
}*/

/*class AddMedPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
        title: Text('Add'),
    ),
    body: Center(child: Text('Mail',style: TextStyle(fontSize: 72))),
    
  );

}*/
