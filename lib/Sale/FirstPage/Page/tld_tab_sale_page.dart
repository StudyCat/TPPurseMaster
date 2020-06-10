import 'dart:async';

import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Page/tld_sale_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../Message/Page/tld_message_page.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';

class TLDTabSalePage extends StatefulWidget {
  TLDTabSalePage({Key key}) : super(key: key);

  @override
  _TLDTabSalePageState createState() => _TLDTabSalePageState();
}

class _TLDTabSalePageState extends State<TLDTabSalePage> with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin{
  List<String> _tabTitles = [
    "挂售中",
    "已完成",
    '已取消'
  ];

  List<Widget> _pages = [
    TLDSalePage(type: 0,), TLDSalePage(type: 1,),TLDSalePage(type: -1,)
  ];

  TabController _tabController;

  StreamSubscription _unreadSubscription;

  bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    _haveUnreadMessage = TLDIMManager.instance.unreadMessage.length > 0;

    _registerUnreadMessageEvent();
  }

  void _registerUnreadMessageEvent(){
    _unreadSubscription = eventBus.on<TLDHaveUnreadMessageEvent>().listen((event) {
      setState(() {
        _haveUnreadMessage = event.haveUnreadMessage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'sale_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TLDMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
        trailing: Container(
            width: ScreenUtil().setWidth(160),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                    child: Icon(
                      IconData(0xe663, fontFamily: 'appIconFonts'),
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TLDOrderListPage()));
                    }),
                MessageButton(
                  isHaveUnReadMessage: _haveUnreadMessage,
                  didClickCallBack: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TLDMessagePage())),
                )
              ],
            )),
      ),
    ));
  }

  Widget _getBodyWidget(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(20)),
          child: TabBar(
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
        ),
        Expanded(
          child: TabBarView(
            children: _pages,
            controller: _tabController,
          )
          )
      ],
    );
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

