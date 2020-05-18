import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_left_bubble.dart';

class TLDIMOtherUserTimeWordMessageCell extends StatefulWidget {
  TLDIMOtherUserTimeWordMessageCell({Key key}) : super(key: key);

  @override
  _TLDIMOtherUserTimeWordMessageCellState createState() =>
      _TLDIMOtherUserTimeWordMessageCellState();
}

class _TLDIMOtherUserTimeWordMessageCellState
    extends State<TLDIMOtherUserTimeWordMessageCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Column(children: <Widget>[
        _getTimeView(context),
        _getMessageBubble(context)
        ]),
    );
  }

  Widget _getTimeView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(170),
        height: ScreenUtil().setHeight(48),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Color.fromARGB(255, 216, 216, 216)),
        child: Text('21:45:30',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Color.fromARGB(255, 51, 51, 51))),
      ),
    );
  }

  Widget _getMessageBubble(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(20), left: ScreenUtil().setWidth(15)),
      child: Row(
        children: <Widget>[
          Container(
            child: TLDLeftBubbleView(
                text: '4564fdsfsdfdsfsdfsdfsdfsdfsdfsdfsdfdsfsdf'),
            constraints: BoxConstraints(maxWidth: size.width / 2),
          )
        ],
      ),
    );
  }
}