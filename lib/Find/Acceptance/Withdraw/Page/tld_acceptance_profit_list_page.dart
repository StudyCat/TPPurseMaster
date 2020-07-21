import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_profit_list_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceProfitListPage extends StatefulWidget {
  TLDAcceptanceProfitListPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceProfitListPageState createState() => _TLDAcceptanceProfitListPageState();
}

class _TLDAcceptanceProfitListPageState extends State<TLDAcceptanceProfitListPage> with AutomaticKeepAliveClientMixin {
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
          
        },
        child : TLDAcceptanceProfitListCell()
      );
     },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}