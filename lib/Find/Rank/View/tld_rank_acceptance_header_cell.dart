import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDRankAcceptanceHeaderCell extends StatefulWidget {
  TLDRankAcceptanceHeaderCell({Key key}) : super(key: key);

  @override
  _TLDRankAcceptanceHeaderCellState createState() => _TLDRankAcceptanceHeaderCellState();
}

class _TLDRankAcceptanceHeaderCellState extends State<TLDRankAcceptanceHeaderCell> {
   @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: ScreenUtil().setSp(24));
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
           Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3, 
            child: Text('排名',style: textStyle,textAlign: TextAlign.center),
          ),
           Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3, 
            child: Text('用户ID',style: textStyle,textAlign: TextAlign.center),
          ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 3, 
            child: Text('每日收益',style: textStyle,textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}