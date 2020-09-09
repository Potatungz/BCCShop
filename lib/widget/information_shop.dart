import 'dart:convert';

import 'package:bccshop/model/user_model.dart';
import 'package:bccshop/screen/add_info_shop.dart';
import 'package:bccshop/screen/edit_info_shop.dart';
import 'package:bccshop/utility/my_const.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfomationShop extends StatefulWidget {
  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString("id");

    String url =
        "${MyConstant().domain}/BCCShop/getUserWhereId.php?isAdd=true&id=$id";
    await Dio().get(url).then((value) {
      print("value = $value");
      var result = json.decode(value.data);
      print("result = $result");
      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });
        print("Nameshop = ${userModel.nameShop}");
      }
    });
  }

  

  void routeToAddInfo() {
    Widget widget = userModel.nameShop.isEmpty ? AddInfoShop() : EditInfoShop(); //เช็ค widget ว่ามีรายละเอียดร้านหรือไม่
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => widget);
    Navigator.push(context, route).then((value) => readDataUser()); //คำสั่งเมื่อกลับมาหน้าใหม่ให้ใช้ .then เพื่อ Refresh ข้อมูลใหม่
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        userModel == null
            ? MyStyle().showProgress()
            : userModel.nameShop.isEmpty
                ? showNoData(context)
                : showListInfoShop(),
                addAndEditButton(),
      ],
    );
  }

  Widget showListInfoShop() => Column(
          children: <Widget>[
            MyStyle().mySizeBox(),
            MyStyle().showTitleH2("รายละเอียดร้าน ${userModel.nameShop}"),
            showImage(),
            Row(
              children: <Widget>[
                MyStyle().showTitleH2("ที่อยู่ร้าน "),
              ],
            ),
            Row(
              children: <Widget>[
                Text(userModel.address),
              ],
            ),
            MyStyle().mySizeBox(),
            showMap()
          ],
        );


  Container showImage() {
    return Container(padding: EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
      width: 300.0,
      //height: 200.0,
      child: Image.network("${MyConstant().domain}${userModel.urlImage}"),
    );
  }

  Set<Marker> shopMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("shopID"),
        position: LatLng(
          double.parse(userModel.lat),
          double.parse(userModel.lng),
        ),
        infoWindow: InfoWindow(
            title: "ตำแหน้งร้าน",
            snippet:
                "ละติจูด = ${userModel.lat}, ลองติจูด = ${userModel.lng} "),
      ),
    ].toSet();
  }

  Widget showMap() {
    double lat = double.parse(userModel.lat);
    double lng = double.parse(userModel.lng);

    LatLng latLng = LatLng(lat, lng);
    CameraPosition position = CameraPosition(target: latLng, zoom: 16.0);

    return Expanded(
      // padding: EdgeInsets.all(8.0),
      // height: 300.0,
      child: GoogleMap(
        initialCameraPosition: position,
        mapType: MapType.normal,
        onMapCreated: (control) {},
        markers: shopMarker(),
      ),
    );
  }

  Widget showNoData(BuildContext context) {
    return MyStyle().titleCenter(context, "ยังไม่มีข้อมูล");
  }

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(18.0),
              child: FloatingActionButton(
                  child: Icon(Icons.edit), onPressed: () => routeToAddInfo()),
            ),
          ],
        ),
      ],
    );
  }
}
