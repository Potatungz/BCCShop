import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/signout_process.dart';
import 'package:bccshop/widget/information_shop.dart';
import 'package:bccshop/widget/order_list_shop.dart';
import 'package:bccshop/widget/products_list_shop.dart';
import 'package:flutter/material.dart';

class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {

  // Field
  Widget currentWidget = OrderListShop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Shop Page"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutProcess(context))
        ],
      ),
      drawer: showDrawer(), body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHead(),
            homeMenu(),
            productsMenu(),
            infomationMenu(),
            signOutMenu(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text("รายการสินค้าที่ลูกค้าสั่ง"),
        subtitle: Text("รายการสินค้าที่ยังไม่ได้ทำส่งลูกค้า"),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile productsMenu() => ListTile(
        leading: Icon(Icons.shopping_basket),
        title: Text("รายการสินค้า"),
        subtitle: Text("ประเภทของสายไฟฟ้า"),
        onTap: () {
          setState(() {
            currentWidget = ProductListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile infomationMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text("รายละเอียดร้านค้า"),
        subtitle: Text("รายละเอียดร้านค้า"),
        onTap: () {
          setState(() {
            currentWidget = InfomationShop();
          });
         Navigator.pop(context);
        },
      );

  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("ออกจากระบบ"),
        subtitle: Text("ออกจากระบบ กลับไปยังหน้าแรก"),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxdecoration("shop.jpg"),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text("Name Shop"),
      accountEmail: Text("Login"),
    );
  }
}
