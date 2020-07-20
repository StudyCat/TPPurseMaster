import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAcceptanceInvitationEarningsUnopenCell extends StatefulWidget {
  TLDAcceptanceInvitationEarningsUnopenCell({Key key}) : super(key: key);

  @override
  _TLDAcceptanceInvitationEarningsUnopenCellState createState() => _TLDAcceptanceInvitationEarningsUnopenCellState();
}

class _TLDAcceptanceInvitationEarningsUnopenCellState extends State<TLDAcceptanceInvitationEarningsUnopenCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20)),
      child: Container(
        padding: EdgeInsets.only(bottom:ScreenUtil().setHeight(20)),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
        ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right:ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(20)),
            child: _getHeaderRowView(),
            ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child: Divider(height: ScreenUtil().setHeight(2),color: Color.fromARGB(255, 219, 218, 216),),
            ),
          Padding(padding: EdgeInsets.only(top : ScreenUtil().setHeight(10)),
          child: Icon(Icons.keyboard_arrow_down,color: Colors.black,),)
        ],
      ),
      ),
      );
  }

  Widget _getHeaderRowView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('一级推广团队(10人)',style: TextStyle(fontSize:ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51)),),
        Column(
          children: <Widget>[
            Text('3234TLD',style: TextStyle(fontSize:ScreenUtil().setSp(36),color: Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold),textAlign: TextAlign.end,),
            Text('总收益',style: TextStyle(fontSize:ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,), 
          ],
        )
      ],
    );
  }

}