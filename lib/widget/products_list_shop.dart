import 'dart:convert';
import 'dart:ui';

import 'package:bccshop/model/product_model.dart';
import 'package:bccshop/screen/add_products_menu.dart';
import 'package:bccshop/screen/edit_product_menu.dart';
import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListShop extends StatefulWidget {
  @override
  _ProductListShopState createState() => _ProductListShopState();
}

class _ProductListShopState extends State<ProductListShop> {
  bool status = true; //Have Data
  bool loadStatus = true; // Pre load
  List<ProductModel> productModels = List();

  @override
  void initState() {
    super.initState();
    readProductMenu();
  }

  Future<Null> readProductMenu() async {
    if (productModels.length != 0) {
      productModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString("id");
    print("idshop = $idShop");
    String url =
        "${MyConstant().domain}/BCCShop/getProductWhereIdShop.php?isAdd=true&idShop=$idShop";
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != "null") {
        // print("value ==> $value");

        var result = json.decode(value.data);
        // print("result ==> $result");

        for (var map in result) {
          ProductModel productModel = ProductModel.fromJson(map);

          setState(() {
            productModels.add(productModel);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadStatus ? MyStyle().showProgress() : showContent(),
        addMenuButton(),
      ],
    );
  }

  Widget showContent() {
    return status
        ? showListProduct()
        : Center(
            child: Text("ยังไม่มีรายการอาหาร"),
          );
  }

  Widget showListProduct() => ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (context, index) => Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Image.network(
                  "${MyConstant().domain}${productModels[index].pathImage}",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(productModels[index].nameProduct,
                        style: MyStyle().mainTitle),
                    Text(
                      "฿${productModels[index].price}",
                      style: MyStyle().mainH2Title,
                    ),
                    Text(
                      productModels[index].detail,
                      style: MyStyle().mainH3Title,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: MyStyle().primaryColor,
                            ),
                            onPressed: (){
                              MaterialPageRoute route = MaterialPageRoute(builder: (context) => EditProductMenu(productModel: productModels[index],));
                              Navigator.push(context, route).then((value) => readProductMenu());
                            }),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteProduct(productModels[index]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ));

  Future<Null> deleteProduct(ProductModel productModel) async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: MyStyle()
                  .showTitleH2("คุณต้องการลบ ${productModel.nameProduct} ?"),
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          String url =
                              "${MyConstant().domain}/BCCShop/deleteProductWhereId.php?isAdd=true&id=${productModel.id}";
                          await Dio()
                              .get(url)
                              .then((value) => readProductMenu());
                        },
                        child: Text("ยืนยัน"),
                      ),
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("ยกเลิก"))
                    ])
              ],
            ));
  }

  Widget addMenuButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => AddProductsMenu(),
                      );
                      Navigator.push(context, route)
                          .then((value) => readProductMenu());
                    },
                    child: Icon(Icons.add),
                  )),
            ],
          ),
        ],
      );
}
