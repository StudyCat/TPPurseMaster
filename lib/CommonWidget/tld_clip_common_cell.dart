import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TLDClipCommonCellType {
  normal, // 两侧文字式样
  normalArrow, //带箭头文字式样
}

class TLDClipCommonCell extends StatefulWidget {
  TLDClipCommonCell(
      {Key key,
      this.type,
      this.title,
      this.titleStyle,
      this.content,
      this.contentStyle})
      : super(key: key);
  final TLDClipCommonCellType type;
  final String title;
  final TextStyle titleStyle;
  final String content;
  final TextStyle contentStyle;

  @override
  _TLDClipCommonCellState createState() => _TLDClipCommonCellState();
}

class _TLDClipCommonCellState extends State<TLDClipCommonCell> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: _getContentView(),
    );
  }

  Widget _getContentView() {
    if (widget.type == TLDClipCommonCellType.normal) {
      return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        child: ListTile(
            leading: Text(
              widget.title,
              style: widget.titleStyle,
            ),
            trailing: Text(
              widget.content,
              style: widget.contentStyle,
            )),
      );
    } else {
      return Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        child: ListTile(
          leading: Text(
            widget.title,
            style: widget.titleStyle,
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                widget.content,
                style: widget.contentStyle,
              ),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
      );
    }
  }
}
