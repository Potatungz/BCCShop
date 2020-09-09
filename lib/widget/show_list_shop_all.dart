import 'dart:convert';

import 'package:bccshop/model/user_model.dart';
import 'package:bccshop/screen/show_shop_product_menu.dart';
import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowListShopAll extends StatefulWidget {
  @override
  _ShowListShopAllState createState() => _ShowListShopAllState();
}

class _ShowListShopAllState extends State<ShowListShopAll> {
   List<UserModel> userModels = List();
  List<Widget> shopCards = List(); 

@override
  void initState() {
    super.initState();
    readShop();
  }

  
  Future<Null> readShop() async {
    String url =
        "${MyConstant().domain}/BCCShop/getUserWhereChooseType.php?isAdd=true&ChooseType=Shop";
    await Dio().get(url).then((value) {
      // print("value = $value");
      var result = json.decode(value.data);

      int index = 0;
      for (var map in result) {
        UserModel model = UserModel.fromJson(map);

        String nameShop = model.nameShop;
        if (nameShop.isNotEmpty) {
          print("object = ${model.nameShop}");
          setState(() {
            userModels.add(model);
            shopCards.add(createCard(model, index));
            index++;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return shopCards.length == 0
          ? MyStyle().showProgress()
          : GridView.extent(
              maxCrossAxisExtent: 300.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: shopCards,
            );
  }

Widget createCard(UserModel userModel, int index) {
    return GestureDetector(
      onTap: () {
        print("you click index $index");
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowShopProductMenu(
            userModel: userModels[index],
          ),
        );
        Navigator.push(context, route);
      },
      child: Card(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 120.0,
                height: 120.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${MyConstant().domain}${userModel.urlImage}"),
                ),
              ),
              MyStyle().mySizeBox(),
              MyStyle().showTitleH2(userModel.nameShop),
            ]),
      ),
    );
  }
}