import 'dart:convert';

import 'package:bccshop/model/user_model.dart';
import 'package:bccshop/screen/main_rider.dart';
import 'package:bccshop/screen/main_shop.dart';
import 'package:bccshop/screen/main_user.dart';
import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
// Field
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Colors.white, MyStyle().lightColor],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showLogo(),
                MyStyle().showTitle("BCC Shop"),
                MyStyle().myDoubleSizeBox(),
                userForm(),
                MyStyle().mySizeBox(),
                passwordForm(),
                MyStyle().mySizeBox(),
                loginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Container(
      width: 320.0,
      height: 50.0,
      child: RaisedButton(
        color: MyStyle().primaryColor,
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, "กรุณากรอกข้อมูลให้ครบถ้วน");
          } else {
            checkAuthen();
          }
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ));

  Future<Null> checkAuthen() async {
    String url =
        "${MyConstant().domain}/BCCShop/getUserWhereUser.php?isAdd=true&User=$user";

    try {
      Response response = await Dio().get(url);
      print("res = $response");

      // แปลงค่า json ให้อ่านค่าเป็นภาษาไทย
      var result = json.decode(response.data);
      print("result = $result");
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.chooseType;
          if (chooseType == "User") {
            routeToService(MainUser(), userModel);
          } else if (chooseType == "Shop") {
            routeToService(MainShop(),userModel);
          } else if (chooseType == "Rider") {
            routeToService(MainRider(),userModel);
          } else {
            normalDialog(context, "เกิดการผิดพลาด");
          }
        } else {
          normalDialog(context, "รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่");
        }
      }
    } catch (e) {}
  }

  Future<Null> routeToService(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", userModel.id);
    preferences.setString("ChooseType", userModel.chooseType);
    preferences.setString("Name", userModel.name);

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

//กำหนด Textfield
  Widget userForm() => Container(
        width: 320.0,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box, color: MyStyle().darkColor),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: "Username",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 320.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: MyStyle().darkColor),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: "Password",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );
}
