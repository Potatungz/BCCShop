import 'package:bccshop/model/cart_model.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/sqlite_helper.dart';
import 'package:flutter/material.dart';

class ShowCart extends StatefulWidget {
  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<CartModel> cartModels = List();
  int total = 0;
  bool status = true;

  @override
  void initState() {
    super.initState();
    readSQLite();
  }

  Future<Null> readSQLite() async {
    var object = await SQLiteHelper().readAllDataFromSQLite();

    if (object.length != 0) {
      for (var model in object) {
        String sumString = model.sum;
        int sumInt = int.parse(sumString);

        setState(() {
          status = false;
          cartModels = object;
          total = total + sumInt;
        });
      }
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ตะกร้าของฉัน")),
      body: status
          ? Center(
              child: Text("ยังไม่มีสินค้าในตะกร้าของคุณ"),
            )
          : buildContent(),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildNameShop(),
            buildTitle(),
            buildListViewProduct(),
            Divider(), // เพิ่มเส้นขีดขั้น
            buildTotal(),
            MyStyle().mySizeBox(),
            buildClearCart()
          ],
        ),
      ),
    );
  }

  Widget buildClearCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton.icon(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              confirmDeleteAllData();
            },
            icon: Icon(Icons.delete_outline),
            label: Text("ลบทั้งหมด")),
      ],
    );
  }

  Widget buildTotal() => Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MyStyle().showTitleH2("TOTAL"),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: MyStyle().showTitleH3Red(total.toString()),
          ),
        ],
      );

  Widget buildNameShop() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              MyStyle().showTitleH2("ร้าน${cartModels[0].nameShop}"),
            ],
          ),
          Row(
            children: <Widget>[
              MyStyle().showTitleH3("ระยะทาง = ${cartModels[0].distance} Km."),
            ],
          ),
          Row(
            children: <Widget>[
              MyStyle()
                  .showTitleH3("ค่าขนส่ง = ${cartModels[0].transport} Bath."),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade400),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: MyStyle().showTitleH2("รายการสินค้า"),
          ),
          Expanded(flex: 1, child: MyStyle().showTitleH2("ราคา")),
          Expanded(flex: 1, child: MyStyle().showTitleH2("จำนวน")),
          Expanded(flex: 1, child: MyStyle().showTitleH2("รวม")),
          Expanded(
            flex: 1,
            child: MyStyle().mySizeBox(),
          )
        ],
      ),
    );
  }

  Widget buildListViewProduct() => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: cartModels.length,
        itemBuilder: (context, index) => Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(cartModels[index].nameProduct),
            ),
            Expanded(
              flex: 1,
              child: Text(cartModels[index].price),
            ),
            Expanded(
              flex: 1,
              child: Text(cartModels[index].amount),
            ),
            Expanded(
              flex: 1,
              child: Text(cartModels[index].sum),
            ),
            Expanded(
                child: IconButton(
              color: Colors.grey.shade400,
              icon: Icon(Icons.delete_forever),
              onPressed: () async {
                int id = cartModels[index].id;
                print("Your Click Delete at id = $id");
                await SQLiteHelper().deleteDataWhereId(id).then((value) {
                  print("Success Delete id = $id");
                  readSQLite();
                });
              },
            ))
          ],
        ),
      );

  Future<Null> confirmDeleteAllData() async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text("คุณแน่ใจว่าต้องการลบทั้งหมด หรือไม่"),
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton.icon(
                        onPressed: () async{
                          Navigator.pop(context);
                          await SQLiteHelper().deleteAllData().then((value) {
                            readSQLite();
                          });
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        label: Text(
                          "ใช่",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                      OutlineButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.clear),
                          label: Text("ไม่")),
                    ])
              ],
            ));
  }
}
