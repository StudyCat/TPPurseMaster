import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Page/tld_acceptance_invitation_detail_earning_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_open_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_search_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_unopen_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceInvitationEarningsPage extends StatefulWidget {
  TLDAcceptanceInvitationEarningsPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceInvitationEarningsPageState createState() => _TLDAcceptanceInvitationEarningsPageState();
}

class _TLDAcceptanceInvitationEarningsPageState extends State<TLDAcceptanceInvitationEarningsPage> {
  @override
  Widget build(BuildContext context) {
    return _getListView();
  }

  Widget _getListView(){
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
      if (index == 0){
        return TLDAcceptanceInvitationEarningsSearchCell();
      }else if (index == 1){
        return TLDAcceptanceInvitationEarningsUnopenCell();
      }else{
        return TLDAcceptanceInvitationOpenCell(
          didClickItemCallBack: (int index){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceInvitationDetailEarningPage()));
          },
        );
      }
     },
    );
  }
}