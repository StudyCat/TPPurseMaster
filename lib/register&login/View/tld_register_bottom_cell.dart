import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDRegisterBottomCell extends StatefulWidget {
  TLDRegisterBottomCell({Key key,this.didClickNextCallBack}) : super(key: key);

  final Function didClickNextCallBack;

  @override
  _TLDRegisterBottomCellState createState() => _TLDRegisterBottomCellState();
}

class _TLDRegisterBottomCellState extends State<TLDRegisterBottomCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),top :ScreenUtil().setHeight(120),right : ScreenUtil().setWidth(30)),
       child: Container(
         height : ScreenUtil().setHeight(80),
         child : CupertinoButton(
           padding: EdgeInsets.zero,
           borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(40))),
           color: Theme.of(context).primaryColor,
           child: Text(I18n.of(context).next,style: TextStyle(fontSize : ScreenUtil().setSp(30),color :Colors.white),),
           onPressed: (){
             widget.didClickNextCallBack();
           },
         )
       ),
    );
  }
}