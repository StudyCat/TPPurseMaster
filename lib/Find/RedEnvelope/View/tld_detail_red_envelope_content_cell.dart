import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDDetailRedEnvelopeContentCell extends StatefulWidget {
  TLDDetailRedEnvelopeContentCell({Key key}) : super(key: key);

  @override
  _TLDDetailRedEnvelopeContentCellState createState() => _TLDDetailRedEnvelopeContentCellState();
}

class _TLDDetailRedEnvelopeContentCellState extends State<TLDDetailRedEnvelopeContentCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),bottom: ScreenUtil().setHeight(0)),
      child: Container(
      decoration: BoxDecoration(color : Colors.white,borderRadius : BorderRadius.all(Radius.circular(4))),
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(0)),
       child: Column(
         children: <Widget>[
           _getContentRowWidget(),
           Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20)),
              child: Divider(
                height: ScreenUtil().setHeight(2),
                color: Color.fromARGB(255, 219, 218, 216),
              ),
            )
         ],
       ),
    ),
    );
  }


  Widget _getLeftColumnWidget(){
    return Column(
      children : <Widget>[
       Text('423423423423',style: TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24))),
        Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child:Text('423423423423',style: TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24))))
      ]
    );
  }

  Widget _getContentRowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getLeftColumnWidget(),
        Text('12TLD',style: TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(32)))
      ],
    );
  }

}