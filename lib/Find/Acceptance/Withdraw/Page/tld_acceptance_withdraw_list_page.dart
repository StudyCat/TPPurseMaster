import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_detail_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_list_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAcceptanceWithdrawListPage extends StatefulWidget {
  TLDAcceptanceWithdrawListPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceWithdrawListPageState createState() => _TLDAcceptanceWithdrawListPageState();
}

class _TLDAcceptanceWithdrawListPageState extends State<TLDAcceptanceWithdrawListPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceDetailWithdrawPage()));
        },
        child : TLDAcceptanceWithdrawListCell()
      );
     },
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
   
}