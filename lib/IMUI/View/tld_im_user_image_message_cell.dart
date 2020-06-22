import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_right_image_bubble.dart';

class TLDIMUserImageMessageCell extends StatefulWidget {
  TLDIMUserImageMessageCell({Key key,this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  _TLDIMUserImageMessageCellState createState() => _TLDIMUserImageMessageCellState();
}

class _TLDIMUserImageMessageCellState extends State<TLDIMUserImageMessageCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),right: ScreenUtil().setWidth(15)),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(360),
            // height: ScreenUtil().setWidth(360),
            child: TLDRightImageBubbleView(imageUrl: widget.imageUrl),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}