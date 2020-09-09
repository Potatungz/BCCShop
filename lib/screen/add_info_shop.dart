import 'dart:io';
import 'dart:math';

import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:bccshop/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
// Field
  double lat, lng;
  File file;
  var _picker = ImagePicker();

  String nameShop, address, phone, urlImage;

  @override
  void initState() {
    super.initState();
    findLatLng(); 
  }

  Future<Null> findLatLng() async {
    
    print("Enter in FindLatLng");
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
      print("Enter Setstate");
    });

    print('lat = $lat, lng = $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();

    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Information Shop"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          MyStyle().mySizeBox(),
          nameForm(),
          MyStyle().mySizeBox(),
          addressForm(),
          MyStyle().mySizeBox(),
          phoneForm(),
          MyStyle().mySizeBox(),
          groupImage(),
          MyStyle().mySizeBox(),
          lat == null ? MyStyle().showProgress() : showMap(), //
          MyStyle().mySizeBox(),
          saveButton()
        ]),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: MyStyle().primaryColor,
        onPressed: () {
          if (nameShop == null ||
              nameShop.isEmpty ||
              address == null ||
              address.isEmpty ||
              phone == null ||
              phone.isEmpty) {
            normalDialog(context, "กรุณากรอกข้อมูลให้ครบทุกช่อง");
          } else if (file == null || file.path.isEmpty) {
            normalDialog(context, "กรุณาเลือกรูปภาพ");
          } else {
            uploadImage();
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

// Upload Image
  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = "shop$i.jpg";
    print("nameImage = $nameImage, pathImage = ${file.path}");

    String url = "${MyConstant().domain}/BCCShop/saveShop.php";

    try {
      Map<String, dynamic> map = Map();
      map["file"] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print("response ==> $value");
        urlImage = "/BCCShop/Shop/$nameImage";
        print("URL Image = $urlImage");
        editUserShop();
      });
    } catch (e) {}
  }

  Future<Null> editUserShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("id");

    String url =
        "${MyConstant().domain}/BCCShop/editUserWhereId.php?isAdd=true&id=$id&NameShop=$nameShop&Address=$address&Phone=$phone&URLImage=$urlImage&Lat=$lat&Lng=$lng";

    await Dio().get(url).then((value) {
      if (value.toString() == "true") {
        Navigator.pop(context);
      } else {
        normalDialog(context, "การบันทึกข้อมูลล้มเหลว! กรุณาลองใหม่");
      }
    });
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("My Shop"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(
              title: "ร้านของคุณ", snippet: "ละติจูด = $lat, ลองติจูด = $lng"))
    ].toSet();
  }

  Container showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }

  Row groupImage() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: 36.0,
              ),
              onPressed: () => chooseImage(ImageSource.camera)),
          Container(
            width: 250.0,
            child: file == null
                ? Image.asset("images/image-not-found.png")
                : Image.file(file),
          ),
          IconButton(
              icon: Icon(
                Icons.add_photo_alternate,
                size: 36.0,
              ),
              onPressed: () => chooseImage(ImageSource.gallery))
        ]);
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var pickedFile = await _picker.getImage(
          source: imageSource, maxHeight: 800.0, maxWidth: 800.0);
      setState(() {
        file = File(pickedFile.path);
      });
    } catch (e) {}
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 360.0,
              child: TextField(
                onChanged: (value) => nameShop = value.trim(),
                decoration: InputDecoration(
                    labelText: "ชื่อร้านค้า",
                    prefixIcon: Icon(Icons.account_box),
                    border: OutlineInputBorder()),
              )),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 360.0,
              child: TextField(
                onChanged: (value) => address = value.trim(),
                decoration: InputDecoration(
                    labelText: "ที่อยู่รา้นค้า",
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder()),
              )),
        ],
      );

  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 360.0,
              child: TextField(
                onChanged: (value) => phone = value.trim(),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "เบอร์ติดต่อรา้นค้า",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder()),
              )),
        ],
      );
}
