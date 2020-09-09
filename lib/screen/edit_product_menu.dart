import 'package:bccshop/model/product_model.dart';
import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:flutter/material.dart';

class EditProductMenu extends StatefulWidget {
  final ProductModel productModel;
  EditProductMenu({Key key, this.productModel}) : super(key: key);

  @override
  _EditProductMenuState createState() => _EditProductMenuState();
}

class _EditProductMenuState extends State<EditProductMenu> {
  ProductModel productModel;
  String productName, productPrice, productDetail;

  @override
  void initState() {
    super.initState();
    productModel = widget.productModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   floatingActionButton: FloatingActionButton(onPressed: (){},
    // child: Icon(Icons.cloud_upload),),
      appBar: AppBar(
        title: Text("แก้ไขข้อมูล ${productModel.nameProduct}"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          MyStyle().mySizeBox(),
          groupImage(),
          nameProduct(),
          priceProduct(),
          detailProduct(),
          MyStyle().mySizeBox(),
          saveButton(),
        ]),
      ),
    );
  }

  Widget groupImage() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.add_a_photo), iconSize: 32.0, onPressed: null),
          Container(
            width: 250.0,
            height: 250.0,
            child: Image.network(
                "${MyConstant().domain}${productModel.pathImage}", fit: BoxFit.cover,),
          ),
          IconButton(icon: Icon(Icons.add_photo_alternate),iconSize: 32.0, onPressed: null)
        ],
      );

  Widget saveButton() => Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: RaisedButton.icon(
          color: MyStyle().primaryColor,
          onPressed: () {},
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          label: Text(
            "บันทึกการแก้ไข",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget nameProduct() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              initialValue: productModel.nameProduct,
              decoration: InputDecoration(
                labelText: "ชื่อสินค้า",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget priceProduct() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              initialValue: productModel.price,
              decoration: InputDecoration(
                labelText: "ราคา",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget detailProduct() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => productDetail = value.trim(),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              initialValue: productModel.detail,
              decoration: InputDecoration(
                labelText: "รายละเอียด",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
