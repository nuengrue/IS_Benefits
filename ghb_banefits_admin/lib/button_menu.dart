import 'package:flutter/material.dart';
import 'package:ghb_banefits_admin/color.dart';


class ButtonMenu extends StatelessWidget {
 // final String iconImagePath;
  final IconData iconImagePath;
  final String buttonText;
  final String index ;


  //final String buttonText;
  const ButtonMenu({Key? key,
  required this.iconImagePath,
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
                height: 120,
                width: 120,
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
                child: Center(
                  child: Icon(iconImagePath,size: 70,
                  color: iOrangeColor,),
                  //Image.asset(iconImagePath),
                ),
              ),
            ),
                        SizedBox(height: 12),
            //text
            Text(buttonText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: iBlueColor,
            ),
            ),
          ],
        );
  }
}


