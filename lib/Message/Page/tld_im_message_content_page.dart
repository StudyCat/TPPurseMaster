import 'dart:async';

import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Message/Model/tld_message_model_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_im_message_cell.dart';

class TLDIMMessageContentPage extends StatefulWidget {
  TLDIMMessageContentPage({Key key}) : super(key: key);

  @override
  _TLDIMMessageContentPageState createState() => _TLDIMMessageContentPageState();
}

class _TLDIMMessageContentPageState extends State<TLDIMMessageContentPage> with AutomaticKeepAliveClientMixin {
  TLDMessageModelManager _modelManager;

  List _dataSource = [];

  StreamSubscription _unreadSubscription;


  @override
  void initState() { 
    super.initState();
    _modelManager = TLDMessageModelManager();

    _searchIMChatGroup();

    _registerUnreadEvent();
  }

  _registerUnreadEvent(){
    _unreadSubscription = eventBus.on<TLDHaveUnreadMessageEvent>().listen((event) {
      if (event.haveUnreadMessage){
        _searchIMChatGroup();
      }
    });
  }

  _searchIMChatGroup(){
    _modelManager.searchChatGroup((List groupList){
      _dataSource = [];
      setState(() {
        _dataSource.addAll(groupList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
      TLDMessageModel messageModel = _dataSource[index];
      return GestureDetector(
        onTap: () => _jumpToChatPage(messageModel),
        child: TLDIMMessageCell(messageModel: messageModel),
      );
     },
    );
  }

  void _jumpToChatPage(TLDMessageModel messageModel){
    List purseList =  TLDDataManager.instance.purseList;
    List addressList = [];
    String selfAddress = '';
    String toAddress = '';
    for (TLDWallet wallet in purseList) {
      addressList.add(wallet.address);
    }
    if (addressList.contains(messageModel.fromAddress)){
      selfAddress = messageModel.fromAddress;
      toAddress = messageModel.toAddress;
    }else{
      selfAddress = messageModel.toAddress;
      toAddress = messageModel.fromAddress;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(selfWalletAddress:selfAddress,otherGuyWalletAddress: toAddress,))).then((value) => _searchIMChatGroup());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _unreadSubscription.cancel();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}