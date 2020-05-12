import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDClipInputCell extends StatefulWidget {
  TLDClipInputCell({Key key,this.placeholder,this.textFieldEditingCallBack}) : super(key: key);

  final String placeholder;
  final ValueChanged<String> textFieldEditingCallBack;

  @override
  _TLDClipInputCellState createState() => _TLDClipInputCellState();
}

class _TLDClipInputCellState extends State<TLDClipInputCell> {

  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController();
    _controller.addListener((){
      widget.textFieldEditingCallBack(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
        child: CupertinoTextField(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
          controller: _controller,
          placeholder: widget.placeholder,
          placeholderStyle: TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24)),
          style: TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24)),
          decoration: BoxDecoration(
            border : Border.all(
              color : Color.fromARGB(0, 0, 0, 0)
            )
          ),
        ),
      ),
    );
  }
}