import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDDetailSaleInfoView extends StatefulWidget {
  TLDDetailSaleInfoView({Key key}) : super(key: key);

  @override
  _TLDDetailSaleInfoViewState createState() => _TLDDetailSaleInfoViewState();
}

class _TLDDetailSaleInfoViewState extends State<TLDDetailSaleInfoView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
      child: Row(
        mainAxisAlignment : MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getSaleInfoLabel('总量', '1839TLD'),
          _getSaleInfoLabel('剩余', '900TLD'),
          _getSaleInfoLabel('状态', '挂售中')
        ],
      ),
    );
  }

  Widget _getSaleInfoLabel(String title,String content){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(title,style: TextStyle(
        fontSize : ScreenUtil().setSp(28),
        color: Theme.of(context).primaryColor
      ),),
      Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
        child: Text(content,style : TextStyle(
          fontSize : ScreenUtil().setSp(28),
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w700
        ),),
      ),
    ],
  );
}

}