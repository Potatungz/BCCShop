import 'dart:io';
import 'dart:math';

import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductsMenu extends StatefulWidget {
  @override
  _AddProductsMenuState createState() => _AddProductsMenuState();
}

class _AddProductsMenuState extends State<AddProductsMenu> {
  String productName, productPrice, productDetail;
  File file;
  var picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เพิ่มรายการสินค้า"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showTitle("รูปสินค้า"),
            groupImage(),
            showTitle("รายละเอียด"),
            nameForm(),
            MyStyle().mySizeBox(),
            priceForm(),
            MyStyle().mySizeBox(),
            detailForm(),
            MyStyle().mySizeBox(),
            saveButton()
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {
          if (file == null) {
            normalDialog(context, "กรุณาเลือกรูปสินค้า");
          } else if (productName == null ||
              productName.isEmpty ||
              productPrice == null ||
              productPrice.isEmpty ||
              productDetail == null ||
              productDetail.isEmpty) {
            normalDialog(context, "กรุณากรอกรายละเอียดให้ครบทุกช่อง");
          } else {
            uploadProductAndInsertData();
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          "บันทึกข้อมูล",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> uploadProductAndInsertData() async {
    String urlUpload = "${MyConstant().domain}/BCCShop/saveProducts.php";

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = "product$i.jpg";

  try {
    Map<String, dynamic> map = Map();
    map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
    FormData formData = FormData.fromMap(map);

    await Dio().post(urlUpload, data: formData).then((value) async{

      String urlPathImage = "/BCCShop/Products/$nameFile";
      print("urlPathImage = ${MyConstant().domain}$urlPathImage");

      SharedPreferences preferences = await SharedPreferences.getInstance();
      String idShop = preferences.getString("id");

      String urlInsertData = "${MyConstant().domain}/BCCShop/addProduct.php?isAdd=true&idShop=$idShop&NameProduct=$productName&PathImage=$urlPathImage&Price=$productPrice&Detail=$productDetail";
      await Dio().get(urlInsertData).then((value) => Navigator.pop(context));

    });


  } catch (e) {
  }
    
  }

  Widget nameForm() {
    return Container(
      width: 300.0,
      child: TextField(
        onChanged: (value) => productName = value.trim(),
        decoration: InputDecoration(
            labelText: "ชื่อสินค้า", border: OutlineInputBorder()),
      ),
    );
  }

  Widget priceForm() {
    return Container(
      width: 300.0,
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) => productPrice = value.trim(),
        decoration:
            InputDecoration(labelText: "ราคา", border: OutlineInputBorder()),
      ),
    );
  }

  Widget detailForm() {
    return Container(
      width: 300.0,
      child: TextField(
        onChanged: (value) => productDetail = value.trim(),
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: InputDecoration(
            labelText: "รายละเอียด", border: OutlineInputBorder()),
      ),
    );
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add_a_photo),
          iconSize: 36.0,
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
            width: 250.0,
            height: 250.0,
            child: file == null
                ? Image.asset("images/image-not-found.png")
                : Image.file(file)),
        IconButton(
          icon: Icon(Icons.add_photo_alternate),
          iconSize: 36.0,
          onPressed: () => chooseImage(ImageSource.gallery),
        )
      ],
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var pickedFile = await picker.getImage(
          source: source, maxWidth: 800.0, maxHeight: 800.0);

      setState(() {
        file = File(pickedFile.path);
      });
    } catch (e) {}
  }

  Widget showTitle(String string) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [MyStyle().showTitleH2(string)],
      ),
    );
  }
}
