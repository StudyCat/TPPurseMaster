import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import '../View/tld_sale_firstpage_cell.dart';

class TLDSalePage extends StatefulWidget {
  TLDSalePage({Key key}) : super(key: key);

  @override
  _TLDSalePageState createState() => _TLDSalePageState();
}

class _TLDSalePageState extends State<TLDSalePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        middle: Text('TLD钱包'),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        automaticallyImplyLeading: false,
        trailing: Container(
          width : ScreenUtil().setWidth(160),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(
                child: Icon(
                  IconData(0xe663, fontFamily: 'appIconFonts'),
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
                padding: EdgeInsets.all(0),
                minSize: 20,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
            MessageButton()
          ],
        )
        ),
      ),);
  }

  Widget _getBody(BuildContext context){
    return ListView.builder(
      itemCount: 11,
      itemBuilder: (BuildContext context, int index) {
      return getSaleFirstPageCell('取消挂售',(){},context);
     },
    );
  }

}