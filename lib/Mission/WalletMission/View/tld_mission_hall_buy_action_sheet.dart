import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDMissionHallBuyActionSheet extends StatefulWidget {
  TLDMissionHallBuyActionSheet({Key key}) : super(key: key);

  @override
  _TLDMissionHallBuyActionSheetState createState() =>
      _TLDMissionHallBuyActionSheetState();
}

class _TLDMissionHallBuyActionSheetState
    extends State<TLDMissionHallBuyActionSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: ScreenUtil().setHeight(440),
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
            _getNormalRowView('数量', '100TLD'),
            _getNormalRowView('应付款', '100CNY'),
            _getArrowRowView('接收地址', 'deiwdgiq120e3030dfh'),
            Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('下单',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )
          ],
        ),
      ),
    );
  }

  Widget _getNormalRowView(String title, String content) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Container(
        width: size.width - ScreenUtil().setWidth(60),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Text(
                content,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 51, 51, 51)),
              )
            ]),
      ),
    );
  }

  Widget _getArrowRowView(String title, String content) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
        child: Container(
          width: size.width - ScreenUtil().setWidth(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Row(children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(400),
                    child: Text(
                      content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 153, 153, 153)),
                    )),
                Icon(Icons.keyboard_arrow_right)
              ])
            ],
          ),
        ));
  }
}
