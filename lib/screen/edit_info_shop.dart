import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bccshop/model/user_model.dart';
import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditInfoShop extends StatefulWidget {
  @override
  _EditInfoShopState createState() => _EditInfoShopState();
}

class _EditInfoShopState extends State<EditInfoShop> {
  UserModel userModel;
  String nameShop, address, phone, urlImage;
  // Location location = Location();

  double lat, lng;

  File file;
  var _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    findLatLng();
    readCurrentInfo();
    // location.onLocationChanged.listen((event) {
    //   setState(() {
    //     lat = event.latitude;
    //     lng = event.longitude;
    //     print("latitude = $lat, longtitude = $lng");
    //   });
    // });
  }

  Future<Null> findLatLng() async{
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
  }

  Future<LocationData> findLocationData() async{
      Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }

  }

  Future<Null> readCurrentInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString("id");

    print("idShop ===> $idShop");

    String url =
        "${MyConstant().domain}/BCCShop/getUserWhereId.php?isAdd=true&id=$idShop";
    Response response = await Dio().get(url);

    print("res ==> $response");

    var result = json.decode(response.data);

    // นำเอาตัว [] ออก
    print("result ===> $result");

    for (var map in result) {
      print("map ===> $map");

      setState(() {
        userModel = UserModel.fromJson(map);
        nameShop = userModel.nameShop;
        address = userModel.address;
        phone = userModel.phone;
        urlImage = userModel.urlImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userModel == null ? MyStyle().showProgress() : showContent(),
      appBar: AppBar(
        title: Text("แก้ไขรายละเอียดร้านค้า"),
      ),
    );
  }

  Widget showContent() => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showImage(),
            nameShopForm(),
            addressShopForm(),
            phoneShopForm(),
            MyStyle().mySizeBox(),
            lat == null ? MyStyle().showProgress() : showMap(),
            MyStyle().mySizeBox(),
            editButton(),
          ],
        ),
      );

  Set<Marker> currentMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("My Marker"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
              title: "ร้านอยู่ที่นี่", snippet: "Lat = $lat, Lng = $lng")),
    ].toSet();
  }

  Container showMap() {
    //LatLng latLng = LatLng(lat, lng);
    //CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 16.0,
    );

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: currentMarker(),
      ),
    );
  }

  Widget editButton() => Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          color: MyStyle().primaryColor,
          onPressed: () => confirmDialog(),
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: Text(
            "บันทึกข้อมูล",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> confirmDialog() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("คุณจะปรับปรุงรายละเอียดร้านใช่มั้ย?"),
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            OutlineButton(
              onPressed: () {
                Navigator.pop(context);
                editThread();
              },
              child: Text("ใช่"),
            ),
            OutlineButton(
              onPressed: () => Navigator.pop(context),
              child: Text("ยกเลิก"),
            )
          ])
        ],
      ),
    );
  }

  Future<Null> editThread() async {
    Random random = Random();
    int i = random.nextInt(100000);
    String nameFile = "editShop$i.jpg";

    String urlUpload = "${MyConstant().domain}/BCCShop/saveShop.php";

    Map<String, dynamic> map = Map();
    map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
    FormData formData = FormData.fromMap(map);

    await Dio().post(urlUpload, data: formData).then((value) async {
      urlImage = "/BCCShop/Shop/$nameFile";
      String id = userModel.id;

      String url =
          "${MyConstant().domain}/BCCShop/editUserWhereId.php?isAdd=true&id=$id&NameShop=$nameShop&Address=$address&Phone=$phone&URLImage=$urlImage&Lat=$lat&Lng=$lng";
      Response response = await Dio().get(url);

      if (response.toString() == "true") {
        Navigator.pop(context);
      } else {
        normalDialog(context, "ไม่สามารถอัพเดทได้ กรุณาลองใหม่");
      }
    });
  }

  Widget showImage() => Container(
        margin: EdgeInsetsDirectional.only(top: 32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.add_a_photo),
                onPressed: () => chooseImage(ImageSource.camera)),
            Container(
              width: 250.0,
              // height: 300.0,
              child: file == null
                  ? Image.network("${MyConstant().domain}$urlImage")
                  : Image.file(file),
            ),
            IconButton(
                icon: Icon(Icons.add_photo_alternate),
                onPressed: () => chooseImage(ImageSource.gallery)),
          ],
        ),
      );

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var pickedFile = await _picker.getImage(
          source: imageSource, maxHeight: 800.0, maxWidth: 800.0);
      setState(() {
        file = File(pickedFile.path);
      });
    } catch (e) {}
  }

  Widget nameShopForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 32.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => nameShop = value,
              initialValue: nameShop,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "ชื่อร้านค้า",
              ),
            ),
          ),
        ],
      );

  Widget addressShopForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => address = value,
              initialValue: address,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "ที่อยู่ร้านค้า",
              ),
            ),
          ),
        ],
      );

  Widget phoneShopForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 300.0,
            child: TextFormField(
              onChanged: (value) => phone = value,
              initialValue: phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "เบอร์ติดต่อ",
              ),
            ),
          ),
        ],
      );
}
