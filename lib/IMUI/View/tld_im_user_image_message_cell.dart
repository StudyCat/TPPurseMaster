import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_right_image_bubble.dart';

class TLDIMUserImageMessageCell extends StatefulWidget {
  TLDIMUserImageMessageCell({Key key}) : super(key: key);

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
            height: ScreenUtil().setWidth(360),
            child: TLDRightImageBubbleView(imageUrl: 'http://img31.mtime.cn/mt/2016/07/28/145303.88789702_96X128.jpg'),
            constraints: BoxConstraints(
              maxWidth: size.width / 2
            ),
            )
        ],
      ),
      );
  }
}