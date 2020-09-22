import 'dart:convert';

import 'package:bccshop/model/cart_model.dart';
import 'package:bccshop/model/product_model.dart';
import 'package:bccshop/model/user_model.dart';
import 'package:bccshop/utility/my_api.dart';
import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/normal_dialog.dart';
import 'package:bccshop/utility/sqlite_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:toast/toast.dart';

class ShowMenuProduct extends StatefulWidget {
  final UserModel userModel;

  ShowMenuProduct({Key key, this.userModel}) : super(key: key);
  @override
  _ShowMenuProductState createState() => _ShowMenuProductState();
}

class _ShowMenuProductState extends State<ShowMenuProduct> {
  UserModel userModel;
  String idShop;
  List<ProductModel> productModels = List();
  int amount = 1;
  double lat1, lat2, lng1, lng2;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    readProductMenu();
    findLocation();
  }

  Future<Null> findLocation() async {
    location.onLocationChanged.listen((event) {
      lat1 = event.latitude;
      lng1 = event.longitude;
      //print("lat1 = $lat1, lng1 = $lng1");
    });
  }

  Future<Null> readProductMenu() async {
    idShop = userModel.id;
    String url =
        "${MyConstant().domain}/BCCShop/getProductWhereIdShop.php?isAdd=true&idShop=$idShop";
    Response response = await Dio().get(url);

    //print("res --> $response");

    var result = json.decode(response.data);

    //print("result = $result");

    for (var map in result) {
      ProductModel productModel = ProductModel.fromJson(map);
      setState(() {
        productModels.add(productModel);
      });
    }
  }

 @override
  Widget build(BuildContext context) {
    return productModels.length == 0
        ? MyStyle().showProgress()
        : ListView.builder(
            itemCount: productModels.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // print('You Click index = $index');
                amount = 1;
                confirmOrder(index);
              },
              child: Row(
                children: <Widget>[
                  showProductImage(context, index),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              productModels[index].nameProduct,
                              style: MyStyle().mainTitle,
                            ),
                          ],
                        ),
                        Text(
                          '${productModels[index].price} บาท',
                          style: TextStyle(
                            fontSize: 32,
                            color: MyStyle().primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 16.0,
                              child: Text(productModels[index].detail),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }


  Container showProductImage(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
      width: MediaQuery.of(context).size.width * 0.5 - 16.0,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            image: NetworkImage(
              "${MyConstant().domain}${productModels[index].pathImage}",
            ),
            fit: BoxFit.cover,
          )),
    );
  }

  Future<Null> confirmOrder(int index) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                productModels[index].nameProduct,
                style: MyStyle().mainTitle,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8.0, bottom: 16.0),
                width: 180.0,
                height: 120.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "${MyConstant().domain}${productModels[index].pathImage}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (amount > 1) {
                            setState(() {
                              amount--;
                              //print("amount = $amount");
                            });
                          }
                        }),
                    MyStyle().mySizeBox(),
                    Text(
                      amount.toString(),
                    ),
                    MyStyle().mySizeBox(),
                    IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() {
                            amount++;
                            //print("amount = $amount");
                          });
                        })
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        onPressed: () => Navigator.pop(context),
                        child: Text("ยกเลิก"),
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: RaisedButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        onPressed: () {
                          Navigator.pop(context);
                          print(
                              "Confirm Order ${productModels[index].nameProduct} Amount = $amount");

                          addOrderToCart(index);
                        },
                        child: Text(
                          "ยืนยัน",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ])
            ],
          ),
        ),
      ),
    );
  }

   Future<Null> addOrderToCart(int index) async {
    String nameShop = userModel.nameShop;
    String idProduct = productModels[index].id;
    String nameProduct = productModels[index].nameProduct;
    String price = productModels[index].price;

    int priceInt = int.parse(price);
    int sumInt = priceInt * amount;

    lat2 = double.parse(userModel.lat);
    lng2 = double.parse(userModel.lng);
    double distance = MyAPI().calculateDistance(lat1, lng1, lat2, lng2);

    var myFormat = NumberFormat('##0.0#', 'en_US');
    String distanceString = myFormat.format(distance);

    int transport = MyAPI().calculateTransport(distance);

    print(
        'idShop = $idShop, nameShop = $nameShop, idProduct = $idProduct, nameProduct = $nameProduct, price = $price, amount = $amount, sum = $sumInt, distance = $distanceString, transport = $transport');

    Map<String, dynamic> map = Map();

    map['idShop'] = idShop;
    map['nameShop'] = nameShop;
    map['idProduct'] = idProduct;
    map['nameProduct'] = nameProduct;
    map['price'] = price;
    map['amount'] = amount.toString();
    map['sum'] = sumInt.toString();
    map['distance'] = distanceString;
    map['transport'] = transport.toString();

    print('map ==> ${map.toString()}');

    CartModel cartModel = CartModel.fromJson(map);

    var object = await SQLiteHelper().readAllDataFromSQLite();
    print('object lenght = ${object.length}');

    if (object.length == 0) {
      await SQLiteHelper().insertDataToSQLite(cartModel).then((value) {
        print('Insert Success');
        showToast('Insert Success');
              });
            } else {
              String idShopSQLite = object[0].idShop;
              print('idShopSQLite ==> $idShopSQLite');
              if (idShop == idShopSQLite) {
                await SQLiteHelper().insertDataToSQLite(cartModel).then((value) {
                  print('Insert Success');
                  showToast('Insert Success ');
                });
              } else {
                normalDialog(context,
                    'ตะกร้ามี รายการสินค้าของร้าน ${object[0].nameShop} กรุณาซื้อสินค้าจากร้านค้าให้เสร็จสิ้น');
              }
            }
          }
        
          void showToast(String string) {
            Toast.show(string, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
          }

}
