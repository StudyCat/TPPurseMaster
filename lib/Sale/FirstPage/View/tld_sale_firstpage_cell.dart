import 'package:dragon_sword_purse/CommonWidget/ltd_sale_buy_cell_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



Widget getSaleFirstPageCell(
    String buttonTitle, Function onPressCallBack, BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.only(left: 15, top: 5, right: 15),
    width: screenSize.width - 30,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        width: screenSize.width - 30,
        padding: EdgeInsets.only(top: 10, bottom: 17),
        child: Column(children: <Widget>[
          getCommonCellHeader('订单号', buttonTitle, onPressCallBack, context,166),
          _leftRightItem(context,34, 0, '收款方式', '', false),
          _leftRightItem(context,22, 0, '挂售钱包', '56456456456645', true),
          _leftRightItem(context, 22, 20, '交易时间', '2020.5.4', true),
        ]),
      ),
    ),
  );
}

Widget _leftRightItem(BuildContext context, num top , num bottom,String title , String content,bool isTextType) {
  Size screenSize = MediaQuery.of(context).size;
  return Container(
    padding: bottom == 0 ? EdgeInsets.only(top : ScreenUtil().setHeight(top)) :EdgeInsets.only(top : ScreenUtil().setHeight(top),bottom: ScreenUtil().setHeight(bottom)),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding : EdgeInsets.only( left :ScreenUtil().setWidth(20)),
          child: Text(title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Container(
          padding : EdgeInsets.only( right :ScreenUtil().setWidth(20)),
          width:  ScreenUtil().setWidth(400),
          alignment: Alignment.centerRight,
          child: isTextType ? Text(content,style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),maxLines: 1,) : Icon(IconData(0xe679,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),)
        ),
      ],
    ),
  );
}
