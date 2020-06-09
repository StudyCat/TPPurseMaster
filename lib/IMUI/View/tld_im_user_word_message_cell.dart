import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_right_bubble.dart';

class TLDIMUserWordMessageCell extends StatefulWidget {
  TLDIMUserWordMessageCell({Key key,this.content}) : super(key: key);

  final String content;

  @override
  _TLDIMUserWordMessageCellState createState() => _TLDIMUserWordMessageCellState();
}

class _TLDIMUserWordMessageCellState extends State<TLDIMUserWordMessageCell> {
  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),right: ScreenUtil().setWidth(15)),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: TLDRightBubbleView(text: widget.content),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}