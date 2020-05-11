import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Page/tld_my_purse_record_page.dart';

class TLDMyPurseContentView extends StatefulWidget {
  TLDMyPurseContentView({Key key}) : super(key: key);

  @override
  _TLDMyPurseContentViewState createState() => _TLDMyPurseContentViewState();
}

class _TLDMyPurseContentViewState extends State<TLDMyPurseContentView>
    with SingleTickerProviderStateMixin {
  List<String> _tabTitles = [
    "全部记录",
    "收款记录",
    "转账记录",
  ];

  TabController _tabController;

  @override
  void initState() {

    super.initState();

    _tabController = TabController(length: _tabTitles.length, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(30)),
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: _tabTitles.map((title) {
              return Tab(text: title);
            }).toList(),
            labelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Color.fromARGB(255, 51, 51, 51),
            unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
          ),
          Expanded(
              child: TabBarView(
            children: [
              TLDMyPurseRecordPage(index: 1,),
              TLDMyPurseRecordPage(index: 2,),
              TLDMyPurseRecordPage(index: 0,),
            ],
            controller: _tabController,
          ))
        ],
      ),
    );
  }

  // @override

  // bool get wantKeepAlive => true;
}
