import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_left_bubble.dart';

class TLDIMOtherUserWordMessageCell extends StatefulWidget {
  TLDIMOtherUserWordMessageCell({Key key,this.content}) : super(key: key);
  final String content;
  @override
  _TLDIMOtherUserWordMessageCellState createState() => _TLDIMOtherUserWordMessageCellState();
}

class _TLDIMOtherUserWordMessageCellState extends State<TLDIMOtherUserWordMessageCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(15)),
      child:  Row(
        children: <Widget>[
          Container(
            child: TLDLeftBubbleView(text: widget.content),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}