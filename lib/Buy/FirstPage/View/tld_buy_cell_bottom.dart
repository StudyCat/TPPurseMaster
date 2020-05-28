import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getCellBottomView(TLDBuyListInfoModel model){
  return Container(
    padding: EdgeInsets.only(top : ScreenUtil().setHeight(18),bottom: ScreenUtil().setHeight(30)),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding : EdgeInsets.only( left :ScreenUtil().setWidth(20)),
          child: Text('收款方式',style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Container(
          padding : EdgeInsets.only( right :ScreenUtil().setWidth(20)),
          width: ScreenUtil().setWidth(200),
          child: Row(
            mainAxisAlignment : MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(IconData(0xe679,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),),
              Icon(IconData(0xe61d,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),),
              Icon(IconData(0xe630,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),),
            ],
          ),
        ),
      ],
    ),
  );
}