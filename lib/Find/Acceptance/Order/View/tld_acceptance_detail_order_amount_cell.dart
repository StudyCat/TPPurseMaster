import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceDetailOrderAmountCell extends StatefulWidget {
  TLDAcceptanceDetailOrderAmountCell({Key key}) : super(key: key);

  @override
  _TLDAcceptanceDetailOrderAmountCellState createState() => _TLDAcceptanceDetailOrderAmountCellState();
}

class _TLDAcceptanceDetailOrderAmountCellState extends State<TLDAcceptanceDetailOrderAmountCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        decoration : BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
          ),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(20), ScreenUtil().setWidth(20), ScreenUtil().setWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _getSingleAmountView(),
            Padding(
              padding: EdgeInsets.only(top :ScreenUtil().setHeight(12)),
              child: _getTotalAmountView(), 
              )
          ],
        ),
      ),
      );
  }

  Widget _getTotalAmountView(){
    return  RichText(
              text: TextSpan(text: '总价',style: TextStyle(color:Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(28)),
                children: <InlineSpan>[
            TextSpan(
                text: '36TLD',
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: ScreenUtil().setSp(36)))
          ]));
  }

  Widget _getSingleAmountView(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
              text: TextSpan(children: <InlineSpan>[
            WidgetSpan(
                child: Icon(
              IconData(0xe670, fontFamily: 'appIconFonts'),
              size: ScreenUtil().setWidth(40),
            )),
            TextSpan(
                text: '  1级票据  X2',
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 102, 102),
                    fontSize: ScreenUtil().setSp(28)))
          ])),
          Text('单价19TLD',
              style: TextStyle(
                  color: Color.fromARGB(255, 102, 102, 102),
                  fontSize: ScreenUtil().setSp(28)))
        ],
      );
  }

}