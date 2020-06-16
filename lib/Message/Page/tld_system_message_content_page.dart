import 'dart:async';

import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_system_message_cell.dart';

class TLDSystemMessageContentPage extends StatefulWidget {
  TLDSystemMessageContentPage({Key key}) : super(key: key);

  @override
  _TLDSystemMessageContentPageState createState() => _TLDSystemMessageContentPageState();
}

class _TLDSystemMessageContentPageState extends State<TLDSystemMessageContentPage> with AutomaticKeepAliveClientMixin {

  TLDIMManager _manager;

  int _page;

  List _dataSource = [];

  RefreshController _refreshController;

  StreamSubscription _messageSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TLDIMManager.instance;
    _manager.isOnChatPage = true;

    _refreshController = RefreshController();

    _page = 0;

    _getSystemList(_page);

    registerEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _messageSubscription.cancel();
  }


  void _getSystemList(int page){
     _manager.getSystemMsssageList(page,
        (List messages) {
      if (page == 0) {
        setState(() {
          _dataSource.addAll(messages);
        });
      } else {
        setState(() {
          _dataSource.insertAll(0, messages);
        });
      }
      if (messages.length > 0) {
        _page = page + 1;
      }
      _refreshController.refreshCompleted();
    });
  }

   //注册广播
  void registerEvent(){
    _messageSubscription = eventBus.on<TLDMessageEvent>().listen((event) {
      for (TLDMessageModel item in event.messageList) {
          if (item.messageType == 1){
            _dataSource.add(item);
          }
        }
      setState(() {
        _dataSource;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(complete: Container()),
      onRefresh: () => _getSystemList(_page),
      child: ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        return TLDSystemMessageCell(messageModel: _dataSource[index],);
     },
    ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}