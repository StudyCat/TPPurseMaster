import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDSystemMessageCell extends StatefulWidget {
  TLDSystemMessageCell({Key key,this.title}) : super(key: key);

  final String title;
  @override
  _TLDSystemMessageCellState createState() => _TLDSystemMessageCellState();
}

class _TLDSystemMessageCellState extends State<TLDSystemMessageCell> {
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          height : ScreenUtil().setHeight(168),
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(28),right: ScreenUtil().setWidth(28),top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
          child : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _getLeftColumnView(),
              _getRightColumnView()
            ],
          ),
        ),
      ),
      );
  }

  Widget _getLeftColumnView(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(10),bottom : ScreenUtil().setHeight(10)),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('TLD官方',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.w700),),
        Text('关于什么什么的通知。',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 102, 102, 102)))
      ],
    ),
      );
  }

  Widget _getRightColumnView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text('早上07:30',style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
        Text('未读',style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 208, 2, 27)))
      ],
    );
  }
}