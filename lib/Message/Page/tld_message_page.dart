import 'package:dragon_sword_purse/Message/Model/tld_message_model_manager.dart';
import 'package:dragon_sword_purse/Message/Page/tld_im_message_content_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_system_message_content_page.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDMessagePage extends StatefulWidget {
  TLDMessagePage({Key key}) : super(key: key);

  @override
  _TLDMessagePageState createState() => _TLDMessagePageState();
}

class _TLDMessagePageState extends State<TLDMessagePage> with TickerProviderStateMixin{
  TabController _tabController;

  List<String> _tabTitles = [
    "通知",
    "系统消息",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {

      eventBus.fire(TLDRefreshMessageListEvent(_tabController.index + 1));
    });
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
        middle: Text('消息'),
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
              TLDIMMessageContentPage(),
              TLDSystemMessageContentPage()
            ],
            controller: _tabController,
          ))
        ],
      );
  }
  

}