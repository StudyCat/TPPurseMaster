import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDRankMineCell extends StatefulWidget {
  TLDRankMineCell({Key key}) : super(key: key);

  @override
  _TLDRankMineCellState createState() => _TLDRankMineCellState();
}

class _TLDRankMineCellState extends State<TLDRankMineCell> {
  @override
  Widget build(BuildContext context) {
   TextStyle textStyle = TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24));
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:  Text('hxud…..',style: textStyle,textAlign: TextAlign.center,), 
         ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:  Text('24',style: textStyle,textAlign: TextAlign.center,), 
         ),
          Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:  Text('200TLD',style: textStyle,textAlign: TextAlign.center,), 
         ),
            Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:  Text('周榜',style: textStyle,textAlign: TextAlign.center,), 
         ),
         Container(
            width : (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 5,
            child:   Text('2020/07/18',style: textStyle,textAlign: TextAlign.center,),
         ),
        ],
      ),
    );
  }
}