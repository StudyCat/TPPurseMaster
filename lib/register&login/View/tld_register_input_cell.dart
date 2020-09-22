import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDRegisterInputCell extends StatefulWidget {
  TLDRegisterInputCell({Key key,this.placeHolder,this.index,this.textDidChangeCallBack}) : super(key: key);

  final String placeHolder;

  final int index;

  final Function textDidChangeCallBack; 

  @override
  _TLDRegisterInputCellState createState() => _TLDRegisterInputCellState();
}

class _TLDRegisterInputCellState extends State<TLDRegisterInputCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(110),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Column(
        children: <Widget>[
          CupertinoTextField(
            padding: EdgeInsets.zero,
            style: TextStyle(fontSize : ScreenUtil().setSp(30),color : Color.fromARGB(255, 51, 51, 51)),
            placeholderStyle:  TextStyle(fontSize : ScreenUtil().setSp(30),color : Color.fromARGB(255, 153, 153, 153)),
            decoration : BoxDecoration(
              border: Border.all(color : Color.fromARGB(0, 0, 0, 0)),
            ),
            inputFormatters: widget.index == 1 ? [WhitelistingTextInputFormatter.digitsOnly] : [],
            placeholder: widget.placeHolder,
            onChanged: (str){
              if (widget.index == 1){
                eventBus.fire(TLDRegisterCellPhoneChangeEvent(str));
              }
              widget.textDidChangeCallBack(str,widget.index);
            },
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child:  Divider(
              height: ScreenUtil().setHeight(2),
              color: Color.fromARGB(255, 221, 221, 221),
            ),
          )
        ],
      ),
    );
  }
}