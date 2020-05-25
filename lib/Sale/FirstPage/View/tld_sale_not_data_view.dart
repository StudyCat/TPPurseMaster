import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDSaleNotDataView extends StatefulWidget {
  TLDSaleNotDataView({Key key}) : super(key: key);

  @override
  _TLDSaleNotDataViewState createState() => _TLDSaleNotDataViewState();
}

class _TLDSaleNotDataViewState extends State<TLDSaleNotDataView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
          child:  Center(
              child: Icon(
            IconData(0xe65d, fontFamily: 'appIconFonts'),
            size: ScreenUtil().setWidth(150),
            color: Color.fromARGB(255, 218, 225, 238),
          )),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
          child: Text('暂无订单',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(200),
              left: ScreenUtil().setWidth(100),
              right: ScreenUtil().setWidth(100)),
          height: ScreenUtil().setHeight(80),
          width: size.width - ScreenUtil().setWidth(200),
          child: CupertinoButton(
              child: Text(
                '出售积分',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28), color: Colors.white),
              ),
              padding: EdgeInsets.all(0),
              color: Theme.of(context).primaryColor,
              onPressed: () {
              }),
        ),
      ],
    ));
  }
}