import 'dart:ui';

import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blueGrey;
  Color lightColor = Colors.blue.shade100;
  Color primaryColor = Colors.blue.shade900;

  Widget showProgress(){
    return Center(child: CircularProgressIndicator(),);
  }

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
          fontSize: 28.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

      TextStyle mainTitle = TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey.shade900,
      );

      TextStyle mainH2Title = TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );

       TextStyle mainH3Title = TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.blueGrey.shade900,
      );

  MyStyle();
}
