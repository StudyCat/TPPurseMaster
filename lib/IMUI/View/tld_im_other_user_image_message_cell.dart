import 'package:dragon_sword_purse/IMUI/View/tld_left_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_left_image_bubble.dart';

class TLDIMOtherUserImageMessageCell extends StatefulWidget {
  TLDIMOtherUserImageMessageCell({Key key,this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  _TLDIMOtherUserImageMessageCellState createState() => _TLDIMOtherUserImageMessageCellState();
}

class _TLDIMOtherUserImageMessageCellState extends State<TLDIMOtherUserImageMessageCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(15)),
      child:  Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(360),
            // height: ScreenUtil().setWidth(360),
            child: TLDLeftImageBubbleView(imageUrl: widget.imageUrl),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}