import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceInvitationDetailHeaderCell extends StatefulWidget {
  TLDAcceptanceInvitationDetailHeaderCell({Key key}) : super(key: key);

  @override
  _TLDAcceptanceInvitationDetailHeaderCellState createState() => _TLDAcceptanceInvitationDetailHeaderCellState();
}

class _TLDAcceptanceInvitationDetailHeaderCellState extends State<TLDAcceptanceInvitationDetailHeaderCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30)),
       child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
         ),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setHeight(20), ScreenUtil().setWidth(20), ScreenUtil().setHeight(20)),
        child: Column(
          children: <Widget>[
            _getRowView('用户ID', 'duqohu012e'),
            Padding(padding:  EdgeInsets.only(top : ScreenUtil().setHeight(10)),
            child: _getRowView('用户手机号', '188 **** 3242'),
            )
          ],
        ),
       ),
    );
  }


  Widget _getRowView(String title,String content){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title,style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51)),),
        Text(content,style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,)
      ],
    );
  }

}