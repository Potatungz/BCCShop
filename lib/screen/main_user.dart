import 'dart:convert';

import 'package:bccshop/model/user_model.dart';
import 'package:bccshop/screen/show_cart.dart';
import 'package:bccshop/screen/show_shop_product_menu.dart';
import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/signout_process.dart';
import 'package:bccshop/widget/show_list_shop_all.dart';
import 'package:bccshop/widget/show_status_product_order.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String nameUser;
  Widget currentWidget;

  @override
  void initState() {
    super.initState();
    currentWidget = ShowListShopAll();
    findUser();
  }

  // เรียกดึงค่า SharedPreferences มาใช้งานในหน้าต่างๆ
  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString("Name");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameUser == null ? "Main User " : "$nameUser login"),
        actions: <Widget>[
          MyStyle().iconShowCart(context),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutProcess(context))
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showHead(),
                menuListShop(),
                menuCart(),
                menuStatusOrder(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                menuSignOut(),
              ],
            )
          ],
        ),
      );

  ListTile menuListShop() {
    return ListTile(
      leading: Icon(Icons.home),
      title: Text("แสดงร้านค้า"),
      subtitle: Text("แสดงร้านค้าที่อยู่ใกล้คุณ"),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowListShopAll();
        });
      },
    );
  }

  ListTile menuStatusOrder() {
    return ListTile(
      leading: Icon(Icons.format_list_numbered),
      title: Text("แสดงรายการสินค้าที่สั่ง"),
      subtitle: Text("แสดงรายการสินค้าที่สั่ง และยังไม่ได้มาส่ง"),
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowStatusProductOrder();
        });
      },
    );
  }

  Widget menuSignOut() {
    return Container(
      decoration: BoxDecoration(color: Colors.red),
      child: ListTile(
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        title: Text(
          "Sign Out",
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          "การออกจากระบบการใช้งาน",
          style: TextStyle(color: Colors.white),
        ),
        onTap: () => signOutProcess(context),
      ),
    );
  }

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxdecoration("user.jpg"),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        nameUser == null ? "Name Login" : nameUser,
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        "Login",
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }

  Widget menuCart() {
    return ListTile(
      leading: Icon(Icons.add_shopping_cart),
      title: Text("ตะกร้าของฉัน"),
      subtitle: Text("รายการสินค้าที่อยู่ในตะกร้าที่ยังไมไ่ด้สั่งซื้อ"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowCart(),
        );
        Navigator.push(context, route);
      },
    );
  }
}
