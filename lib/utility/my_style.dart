import 'dart:ui';

import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.green.shade300;

  SizedBox mySizeBox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );
  SizedBox myDoubleSizeBox() => SizedBox(
        width: 8.0,
        height: 64.0,
      );

  BoxDecoration myBoxdecoration(String namePic) {
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/$namePic"), fit: BoxFit.cover));
  }

  Container showLogo() =>
      Container(width: 150.0, child: Image.asset("images/logo.png"));

  Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(width: MediaQuery.of(context).size.width*0.5,
        child: Text(
          string,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 28,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

  MyStyle();
}
