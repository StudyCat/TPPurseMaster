import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_profit_list_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceWithdrawTabPage extends StatefulWidget {
  TLDAcceptanceWithdrawTabPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceWithdrawTabPageState createState() => _TLDAcceptanceWithdrawTabPageState();
}

class _TLDAcceptanceWithdrawTabPageState extends State<TLDAcceptanceWithdrawTabPage> with SingleTickerProviderStateMixin {
 TabController _tabController;

  List<String> _tabTitles = [
    "提现",
    "收益记录",
    '提现记录'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'message_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑账户'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(50),
                right: ScreenUtil().setWidth(50),
                top: ScreenUtil().setHeight(20)),
            child: TabBar(
              tabs: _tabTitles.map((title) {
                return Tab(text: title);
              }).toList(),
              labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
              indicatorColor: Theme.of(context).hintColor,
              labelColor: Color.fromARGB(255, 51, 51, 51),
              unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
          Expanded(
              child: TabBarView(
            children: [
              TLDAcceptanceWithdrawListPage(),
              TLDAcceptanceProfitListPage(),
              TLDAcceptanceWithdrawListPage()
            ],
            controller: _tabController,
          ))
        ],
      );
  }
}