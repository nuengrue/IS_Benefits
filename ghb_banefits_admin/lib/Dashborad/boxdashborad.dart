import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/color.dart';


class BoxDashborad extends StatelessWidget {
 // final String iconImagePath;
  final int countnum;
  final String buttonText;
  final Color indexColor ;


  //final String buttonText;
  const BoxDashborad({Key? key,
  required this.countnum,
  required this.buttonText, 
  required this.indexColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
             Text(buttonText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: iBlueColor,
            ),
            ),
            SizedBox(height: 12),
          //  InkWell(
          //   onTap: () {
          //     Navigator.pushNamed(context, index);
          //   },
              // child: 
              Container(
                height: 80,
                width: 150,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: indexColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Center(
                  child:  Text(countnum.toString(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: iBlackColor,
            ),
            ),
                  //Image.asset(iconImagePath),
                ),
              ),
            // ),
            //             SizedBox(height: 12),
            // //text
            // Text(buttonText,
            // style: TextStyle(
            //   fontSize: 14,
            //   fontWeight: FontWeight.bold,
            //   color: iBlueColor,
            // ),
            // ),
          ],
        );
  }
}


