import 'package:bccshop/screen/main_rider.dart';
import 'package:bccshop/screen/main_shop.dart';
import 'package:bccshop/screen/main_user.dart';
import 'package:bccshop/screen/signIn.dart';
import 'package:bccshop/screen/signup.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {

    super.initState();
    checkPreferance();
  }

// เช็ค Preferance ก่อนเข้าแอพเพื่อดึงค่าล่าสุดมาใช้งาน
  Future<Null> checkPreferance() async{

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String chooseType = preferences.getString("ChooseType");

      if (chooseType != null && chooseType.isNotEmpty ) {
        if (chooseType == "User") {
          routeToService(MainUser());
        } else if(chooseType == "Shop"){
          routeToService(MainShop());
        }else if(chooseType == "Rider"){
          routeToService(MainRider());
        }else{
          normalDialog(context, "Error User Type");
        }
      }
    } catch (e) {
    }

  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget,);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(children: <Widget>[
          showHeaderDrawer(),
          signInMenu(),
          signUpMenu(),
        ]),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("Sign In"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("Sign Up"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignUp());
        Navigator.push(context, route);
      },
    );
  }
}

UserAccountsDrawerHeader showHeaderDrawer() {
  return UserAccountsDrawerHeader(
    decoration: MyStyle().myBoxdecoration("guest.jpg"),
    currentAccountPicture: MyStyle().showLogo(),
    accountName: Text("Guest"),
    accountEmail: Text("Please Login"),
  );
}
