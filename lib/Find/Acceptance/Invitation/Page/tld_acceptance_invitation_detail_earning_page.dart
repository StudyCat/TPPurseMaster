import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_detail_earning_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_detail_earning_header_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class TLDAcceptanceInvitationDetailEarningPage extends StatefulWidget {
  TLDAcceptanceInvitationDetailEarningPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceInvitationDetailEarningPageState createState() => _TLDAcceptanceInvitationDetailEarningPageState();
}

class _TLDAcceptanceInvitationDetailEarningPageState extends State<TLDAcceptanceInvitationDetailEarningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'detail_earning_page',
        transitionBetweenRoutes: false,
        middle: Text('收益详情'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        if(index == 0){
          return TLDAcceptanceInvitationDetailHeaderCell();
        }else if(index == 4){
          return _getBottomCell();
        }else{
          return TLDAcceptanceInvitationDetailEarningCell();
        }
     },
    );
  }


  Widget _getBottomCell(){
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20)),
       child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
         ),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0, ScreenUtil().setHeight(20)),
        child: Row(
          children: <Widget>[
            Text('推广收益总计',style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51)),),
        Text('400TLD',style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,)
          ],
        ),
       ),
    );
  }

}