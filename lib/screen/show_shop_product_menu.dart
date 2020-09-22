import 'package:bccshop/model/user_model.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/widget/about_shop.dart';
import 'package:bccshop/widget/show_menu_product.dart';
import 'package:flutter/material.dart';

class ShowShopProductMenu extends StatefulWidget {
  final UserModel userModel;
  ShowShopProductMenu({Key key, this.userModel}) : super(key: key);

  @override
  _ShowShopProductMenuState createState() => _ShowShopProductMenuState();
}

class _ShowShopProductMenuState extends State<ShowShopProductMenu> {
  UserModel userModel;
  List<Widget> listWidgets = List();
  int indexPage = 0;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    listWidgets.add(AboutShop(
      userModel: userModel,
    ));
    listWidgets.add(ShowMenuProduct(
      userModel: userModel,
    ));
  }

  BottomNavigationBarItem aboutShopNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.account_box),
      title: Text("รายละเอียดร้าน"),
    );
  }

  BottomNavigationBarItem showMenuProductNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.list),
      title: Text("รายการสินค้า"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[MyStyle().iconShowCart(context)],
        title: Text(userModel.nameShop),
      ),
      body: listWidgets.length == 0
          ? MyStyle().showProgress()
          : listWidgets[indexPage],
      bottomNavigationBar: showBottomNavigationBar(),
    );
  }

  BottomNavigationBar showBottomNavigationBar() => BottomNavigationBar(
        selectedItemColor: Colors.blue.shade900,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: <BottomNavigationBarItem>[
          aboutShopNav(),
          showMenuProductNav(),
        ],
      );
}
