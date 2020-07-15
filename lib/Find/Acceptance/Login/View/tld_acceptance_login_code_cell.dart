import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceLoginCodeCell extends StatefulWidget {
  TLDAcceptanceLoginCodeCell({Key key,this.title,this.placeholder}) : super(key: key);

  final String title;

  final String placeholder;

  @override
  _TLDAcceptanceLoginCodeCellState createState() => _TLDAcceptanceLoginCodeCellState();
}

class _TLDAcceptanceLoginCodeCellState extends State<TLDAcceptanceLoginCodeCell> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                    fontSize:  ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Expanded(
                child: CupertinoTextField(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                    bottom: ScreenUtil().setHeight(20)),
                controller: _controller,
                placeholder: widget.placeholder,
                textAlign: TextAlign.right,
                placeholderStyle: TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: ScreenUtil().setSp(24)),
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24)),
                decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
              ),
              ),
              Padding(
                padding: EdgeInsets.only(left : ScreenUtil().setWidth(10),right:0,top: 0,bottom: 0),
                child: Container(
                  width : ScreenUtil().setWidth(176),
                  child : CupertinoButton(
                    child: Text('发送验证码',style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Colors.white)),
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    onPressed: (){},
                  )
                ),
                )
            ]),
      ),
    );
  }
}