import 'package:bccshop/model/user_model.dart';
import 'package:flutter/material.dart';

class ShowShopProductMenu extends StatefulWidget {
final UserModel userModel;
ShowShopProductMenu({Key key, this.userModel}) : super(key: key);

  @override
  _ShowShopProductMenuState createState() => _ShowShopProductMenuState();
}

class _ShowShopProductMenuState extends State<ShowShopProductMenu> {

  UserModel userModel;

@override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(userModel.nameShop),
    ),
      
    );
  }
}