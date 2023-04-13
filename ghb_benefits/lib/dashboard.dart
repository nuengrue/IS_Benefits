/*
import 'package:flutter/material.dart';
import 'package:ghb_benefits/color.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboards extends StatelessWidget {
  Dashboards({Key? key}) : super(key: key);

  Map<String, double> dataMap = {
    "เงินที่ใช้ไป": 8000,
    "เงินที่ใช้ได้": 32000,
    //"Xamarin": 2,
    //"Ionic": 2,
  };

  List<Color> colorList = [
    Colors.greenAccent,
        Colors.black,

  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              //height: double.infinity,
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: iWhiteColor,
                ),
                color: iWhiteColor,
                /*
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                  )
                ],
                */
              ),
            
        //padding: EdgeInsets.symmetric(horizontal: 16),
        child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          baseChartColor: Colors.grey[50]!.withOpacity(0.15),
          colorList: colorList,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
          totalValue: 40000,
        ),
      );
    
  }
}

class dataMap {
  final String name;
  final double no;
  dataMap(this.name, this.no, );

  factory dataMap.fromJson(Map<String, dynamic> json) {
    return dataMap(
      json['name'] as String,
      json['no'] as double,
    );
  }
}
      
            //SizedBox(height: 10),

            /*
                        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cars[index].Brand.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  cars[index].Img.toString(),
                  height: 50,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cars[index].Brand.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  cars[index].Img.toString(),
                  height: 50,
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
              cars[index].Model.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cars[index].Color.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  cars[index].Licence.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  cars[index].Refeul.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
           
           */
           /*
          ],
        ),
      ),
    );
       // );

          },
          );
  }
  */
  */