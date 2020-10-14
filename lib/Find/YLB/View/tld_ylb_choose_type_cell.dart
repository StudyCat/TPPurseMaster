import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_choose_type_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDYLBChooseTypeCell extends StatefulWidget {
  TLDYLBChooseTypeCell({Key key,this.typeModel}) : super(key: key);

  final TLDYLBTypeModel typeModel;

  @override
  _TLDYLBChooseTypeCellState createState() => _TLDYLBChooseTypeCellState();
}

class _TLDYLBChooseTypeCellState extends State<TLDYLBChooseTypeCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30)),
       child: Container(
         padding : EdgeInsets.only(left: ScreenUtil().setWidth(20),right:ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
         decoration: BoxDecoration(
           color : Colors.white,
           borderRadius : BorderRadius.all(Radius.circular(4))
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Text(widget.typeModel.typeName,style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28))),
             Padding(padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),),
              child: Text('${widget.typeModel.balance} TLD',style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(32),fontWeight: FontWeight.bold)),
             )
           ],
         ),
       ),
    );
  }
}