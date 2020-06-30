import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDMissionFirstMyMissionCell extends StatefulWidget {
  TLDMissionFirstMyMissionCell({Key key,this.didClickItemCallBack}) : super(key: key);
  
  final Function didClickItemCallBack;

  @override
  _TLDMissionFirstMyMissionCellState createState() =>
      _TLDMissionFirstMyMissionCellState();
}

class _TLDMissionFirstMyMissionCellState
    extends State<TLDMissionFirstMyMissionCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.didClickItemCallBack,
      child: Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setHeight(10)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: _getLeftColumnView(),
      ),
    ),
    );
  }

  Widget _getLeftColumnView() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(20),
          bottom: ScreenUtil().setHeight(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('任务',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
            child: _getRichText('任务时间段 ', '14:00—18:00'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
            child: _getRichText('结束剩余时间 ', '2时30分'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
            child: _getRichText('钱包地址', 'fdsfsdfsfsfdsfsfsdfsdfsfs'),
          )
        ],
      ),
    );
  }

  Widget _getRichText(String title, String content) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(24),
            color: Color.fromARGB(255, 153, 153, 153)),
        children: <InlineSpan>[
          TextSpan(
              text: content,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51)))
        ],
      ),
    );
  }
}
