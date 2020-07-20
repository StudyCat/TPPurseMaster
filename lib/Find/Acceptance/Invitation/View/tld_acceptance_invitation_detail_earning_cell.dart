import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAcceptanceInvitationDetailEarningCell extends StatefulWidget {
  TLDAcceptanceInvitationDetailEarningCell({Key key}) : super(key: key);

  @override
  _TLDAcceptanceInvitationDetailEarningCellState createState() => _TLDAcceptanceInvitationDetailEarningCellState();
}

class _TLDAcceptanceInvitationDetailEarningCellState extends State<TLDAcceptanceInvitationDetailEarningCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20)),
       child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
         ),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0, ScreenUtil().setHeight(20)),
        child: Column(
          children: <Widget>[
            _getRowView('1级票据(1份)', '200TLD',TextStyle(fontSize: ScreenUtil().setSp(32),
              color: Color.fromARGB(255, 51, 51, 51))),
            _getDoubleCircle(),
            _getRowView('推广收益  100TLD', '总额',TextStyle(fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 153, 153, 153)))
          ],
        ),
       ),
    );
  }

  Widget _getDoubleCircle(){
    return SizedBox(
      height: 18,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            child: Container(
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          Positioned(
            left: -9,
            child: _getCardCircle(),
          ),
          Positioned(
            right: -9,
            child: _getCardCircle(),
          ),
        ],
      ),
    );
  }

  Widget _getCardCircle() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 242, 242, 242),
      ),
    );
  }

   Widget _getRowView(String title,String content,TextStyle textStyle){
    return Padding(padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right:ScreenUtil().setWidth(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title,style: textStyle,),
        Text(content,style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,)
      ],
    ),);
  }
}
