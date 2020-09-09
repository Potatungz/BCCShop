import 'package:bccshop/utility/my_const.dart';
import 'package:dio/dio.dart';

import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/normal_dialog.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          myLogo(),
          MyStyle().mySizeBox(),
          showAppName(),
          MyStyle().myDoubleSizeBox(),
          nameForm(),
          MyStyle().mySizeBox(),
          userForm(),
          MyStyle().mySizeBox(),
          passwordForm(),
          MyStyle().mySizeBox(),
          MyStyle().showTitleH2("เลือกประเภทการสมัคร"),
          MyStyle().mySizeBox(),
          userRadio(),
          shopRadio(),
          riderRadio(),
          MyStyle().mySizeBox(),
          registerButton()
        ],
      ),
    );
  }

  Widget registerButton() => Container(
      width: 320.0,
      height: 50.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        onPressed: () {
          print(
              "name = $name, user = $user, password = $password, choosetype = $chooseType");
          if (name == null ||
              name.isEmpty ||
              user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            print("No data");
            normalDialog(context, "กรุณากรอกข้อมูลให้ครบถ้วน");
          }else if(chooseType == null ){
            normalDialog(context, "กรุณาเลือกประเภทการสมัคร");
          }else{
            checkUserThread();
          }
        },
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ));

      Future<Null> checkUserThread() async{
        String url = "${MyConstant().domain}/BCCShop/getUserWhereUser.php?isAdd=true&User=$user";

        try {
          Response response = await Dio().get(url);

          if (response.toString() == "null") {
               registerThread();
          } else {
            normalDialog(context, "$user นี้ถูกใช้ไปแล้ว กรุณาเปลี่ยน user ใหม่");
          }

        } catch (e) {
        }
      }

      Future<Null> registerThread()async{
        String url = "${MyConstant().domain}/BCCShop/addUser.php?isAdd=true&Name=$name&User=$user&Password=$password&ChooseType=$chooseType";

        // หากเสี่ยงต่อการ error ให้ทำการใช้ฟังก์ชั่น try ครอบไว้ก่อน
        try {
          Response response = await Dio().get(url);
          print("res =$response");

          if (response.toString() == "true") {
            Navigator.pop(context);
          } else {
            normalDialog(context, "ล้มเหลว!! กรุณาสมัครใหม่อีกครั้ง");
          }

        } catch (e) {

        }
      }

  Widget userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: "User",
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  "ผู้สั่งอาหาร",
                  style: TextStyle(color: MyStyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget shopRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: "Shop",
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  "เจ้าของร้าน",
                  style: TextStyle(color: MyStyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget riderRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: "Rider",
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  "ผู้ส่งอาหาร",
                  style: TextStyle(color: MyStyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyStyle().showTitle("BCC Shop"),
      ],
    );
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 320.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.account_box, color: MyStyle().darkColor),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: "Name",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 320.0,
            child: TextField(
              onChanged: (value) => user = value.trim(),
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.account_box, color: MyStyle().darkColor),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: "Username",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 320.0,
            child: TextField(
              obscureText: true,
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.account_box, color: MyStyle().darkColor),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: "Password",
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyStyle().showLogo(),
        ],
      );
}
