import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/signout_process.dart';
import 'package:flutter/material.dart';

class MainRider extends StatefulWidget {
  @override
  _MainRiderState createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Rider Page"),actions: <Widget>[IconButton(icon: Icon(Icons.exit_to_app), onPressed: () => signOutProcess(context))],
      ),drawer: showDrawer(),
    );
  }

    Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(decoration: MyStyle().myBoxdecoration("rider.jpg"),
              currentAccountPicture: MyStyle().showLogo(),
              accountName: Text("Name Shop"),
              accountEmail: Text("Login"),
            )
          ],
        ),
      );
}
