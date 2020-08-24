import 'package:bccshop/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddInfoShop extends StatefulWidget {
  @override
  _AddInfoShopState createState() => _AddInfoShopState();
}

class _AddInfoShopState extends State<AddInfoShop> {
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
          showMap(),
          MyStyle().mySizeBox(),
          saveButton()
        ]),
      ),
    );
  }

  Widget saveButton() {
    return Container(width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(color: MyStyle().primaryColor,
            onPressed: () {},
            icon: Icon(Icons.save ,color: Colors.white,),
            label: Text("บันทึกข้อมูล" ,style: TextStyle(color: Colors.white),),
          ),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(13.576716, 101.004451);
    CameraPosition cameraPosition = CameraPosition(target: latLng, zoom: 16.0);

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
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
              onPressed: () {}),
          Container(
            width: 250.0,
            child: Image.asset("images/image-not-found.png"),
          ),
          IconButton(
              icon: Icon(
                Icons.add_photo_alternate,
                size: 36.0,
              ),
              onPressed: () {})
        ]);
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 360.0,
              child: TextField(
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
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "เบอร์ติดต่อรา้นค้า",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder()),
              )),
        ],
      );
}
