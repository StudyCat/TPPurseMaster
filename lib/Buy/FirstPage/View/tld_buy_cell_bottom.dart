import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getCellBottomView(TLDBuyListInfoModel model){
  int iconInt;
  if (model.payMethodVO.type == 1){
    iconInt = 0xe679;
  }else if(model.payMethodVO.type == 2){
    iconInt = 0xe61d;
  }else{
    iconInt = 0xe630;
  }
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
            mainAxisAlignment : MainAxisAlignment.end,
            children: <Widget>[
              Icon(IconData(iconInt,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),),
            ],
          ),
        ),
      ],
    ),
  );
}