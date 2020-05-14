import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_buy_action_sheet_input_view.dart';

class TLDBuyActionSheet extends StatefulWidget {
  TLDBuyActionSheet({Key key}) : super(key: key);

  @override
  _TLDBuyActionSheetState createState() => _TLDBuyActionSheetState();
}

class _TLDBuyActionSheetState extends State<TLDBuyActionSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: ScreenUtil().setHeight(580),
      width: size.width,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('购买',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 51, 51, 51),
                  decoration: TextDecoration.none)),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: TLDBuyActionSheetInputView(),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView('限额', '100TLD'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView('实际付款', '100RMB'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getArrowView('接收地址', 'dsadasdasdada'),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('下单',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){}
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )],
      ),
    );
  }

  Widget getNormalView(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
      ],
    );
  }

  Widget getArrowView(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Row(children: <Widget>[
          Text(
            content,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 153, 153, 153)),
          ),
          Icon(Icons.keyboard_arrow_right)
        ])
      ],
    );
  }
}
