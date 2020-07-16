import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAcceptanceBillListLockCell extends StatefulWidget {
  TLDAcceptanceBillListLockCell({Key key}) : super(key: key);

  @override
  _TLDAcceptanceBillListLockCellState createState() => _TLDAcceptanceBillListLockCellState();
}

class _TLDAcceptanceBillListLockCellState extends State<TLDAcceptanceBillListLockCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(10),left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),bottom : ScreenUtil().setHeight(20)),
        height: ScreenUtil().setHeight(96),
        decoration : BoxDecoration(
          borderRadius : BorderRadius.all(Radius.circular(4)),
          color : Colors.white
        ),
        child: Stack(
          children : <Widget>[
            Padding(
            child:  Container(
              width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
              child: Text('3级TLD票据：100每份（1/4）',style : TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize : ScreenUtil().setSp(28),),textAlign: TextAlign.center,),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20)
          ),
          Positioned(right: ScreenUtil().setWidth(20),
            child: Icon(IconData(0xe60b,fontFamily : 'appIconFonts'),color: Color.fromARGB(255, 153, 153, 153),size: ScreenUtil().setSp(28),))
          ]
        ),
      ),
      );
  }
}