import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/color.dart';


class ListDashborad extends StatelessWidget {
 // final String iconImagePath;
  //final IconData iconImagePath;
  final String buttonText;
  final String index ;


  //final String buttonText;
  const ListDashborad({Key? key,
  //required this.iconImagePath,
  required this.buttonText, 
  required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
           InkWell(
            onTap: () {
              Navigator.pushNamed(context, index);
            },
              child: Container(
                height: 70,
                width: 320,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child:   Text(buttonText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: iBlueColor,
            ),
            ),
              ),
            ),
                        SizedBox(height: 12),
            //text
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


