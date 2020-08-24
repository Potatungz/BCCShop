import 'package:bccshop/screen/add_info_shop.dart';
import 'package:bccshop/utility/my_style.dart';
import 'package:flutter/material.dart';

class InfomationShop extends StatefulWidget {
  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  void routeToAddInfo(){
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => AddInfoShop());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyStyle().titleCenter(context, "ยังไม่มีข้อมูล"),
        addAndEditButton()
      ],
    );
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
                  child: Icon(Icons.edit),
                  onPressed: () => routeToAddInfo()),
            ),
          ],
        ),
      ],
    );
  }
}
