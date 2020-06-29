import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDMissionFirstMissionCell extends StatefulWidget {
  TLDMissionFirstMissionCell({Key key,this.didClickGetBtnCallBack}) : super(key: key);

  final Function didClickGetBtnCallBack;

  @override
  _TLDMissionFirstMissionCellState createState() =>
      _TLDMissionFirstMissionCellState();
}

class _TLDMissionFirstMissionCellState
    extends State<TLDMissionFirstMissionCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          bottom: ScreenUtil().setHeight(10)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getLeftColumnView(),
            Container(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
              height: ScreenUtil().setHeight(60),
              width: ScreenUtil().setWidth(144),
              child: CupertinoButton(
                  child: Text(
                    '领取',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                  ),
                  padding: EdgeInsets.all(0),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setHeight(30))),
                  onPressed: widget.didClickGetBtnCallBack),
            )
          ],
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
                  color: Color.fromARGB(255, 51, 51, 51))),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
            child: _getRichText('任务时间段 ', '14:00—18:00'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(12)),
            child: _getRichText('结束剩余时间 ', '2时30分'),
          ),
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
