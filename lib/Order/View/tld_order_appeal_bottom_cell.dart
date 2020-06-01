import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDOrderAppealBottomCell extends StatefulWidget {
  TLDOrderAppealBottomCell({Key key,this.didClickSureBtnCallBack}) : super(key: key);

  final Function didClickSureBtnCallBack;

  @override
  _TLDOrderAppealBottomCellState createState() => _TLDOrderAppealBottomCellState();
}

class _TLDOrderAppealBottomCellState extends State<TLDOrderAppealBottomCell> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(120),
            left: ScreenUtil().setWidth(100),
            right: ScreenUtil().setWidth(100)),
        child: Container(
        height: ScreenUtil().setHeight(80),
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          onPressed: () => widget.didClickSureBtnCallBack(),
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Text(
            '提交',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Colors.white,
          ),
        ))));
  }
}