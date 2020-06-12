
import 'dart:async';
import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Notification/tld_im_message_notification.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;


class TLDMessageModel {
  int contentType;
  String content;
  String fromAddress;
  String  toAddress;
  int id;
  bool unread;
  int createTime;

  TLDMessageModel(
      {this.contentType,
      this.content,
      this.fromAddress,
      this.toAddress,
      this.createTime
      });

  TLDMessageModel.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    content = json['content'];
    fromAddress = json['fromAddress'];
    toAddress = json['toAddress'];
    createTime = json['createTime'];
    unread =  json['unread'] == 1 ? true : false; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentType'] = this.contentType;
    data['content'] = this.content;
    data['fromAddress'] = this.fromAddress;
    data['toAddress'] = this.toAddress;
    data['createTime'] = this.createTime;
    // data['unread'] = this.unread ? 1 : 0;
    return data;
  }
}


class TLDIMManager{

  factory TLDIMManager(String walletAddress) =>_getInstance();
  static TLDIMManager get instance => _getInstance();
  static TLDIMManager _instance;

  String walletAddress;
  Timer timer;
  bool isOnChatPage = false;
  List unreadMessage = [];//未读消息数组
  String talkAddress = '';//聊天地址
  IOWebSocketChannel channel;
   bool isInBackState = false;

  TLDIMManager._internal() {
    // 初始化

  }

   connectClient() async{
    if(timer != null){
      timer.cancel();
      timer = null;
    }
    
    await _searchAllUnReadMessageInDB();

    channel = IOWebSocketChannel.connect("ws://192.168.1.120:8030/webSocket/"+ this.walletAddress);
     channel.stream.listen(( message)async { 
      if (message == 'pong'){
        return;
      }
      Map map =  jsonDecode(message);
      if (map != null){
        Map data = map['data'];
        List messageList = data['list'];
        List result = [];
        bool isHaveUnreadMessage = false;
        for (Map item in messageList) {
          TLDMessageModel messageModel = TLDMessageModel.fromJson(item);
          if (this.isOnChatPage == true && (messageModel.toAddress == talkAddress || messageModel.fromAddress == talkAddress)){
            messageModel.unread = false;
          }else{
            messageModel.unread = true;
            isHaveUnreadMessage = true;
            this.unreadMessage.add(messageModel);
          }
          result.add(messageModel); 
        }
        TLDDataBaseManager dataManager = TLDDataBaseManager();
        await dataManager.openDataBase();
        await dataManager.insertIMDataBase(result);
        await dataManager.closeDataBase();
        eventBus.fire(TLDMessageEvent(result));
        if (isHaveUnreadMessage == true){
          eventBus.fire(TLDHaveUnreadMessageEvent(true)); 
        }
      }
    },onError: (error){
      if (!this.isInBackState){
        connectClient();
      }
    },onDone: (){
      if (!this.isInBackState){
        connectClient();
      }
    });
    timer = Timer.periodic(Duration(seconds : 30), (timer) { 
      sendHeartMessage();
    });
  }

  //移除进入聊天界面之后编程已读状态的消息
  _removeUnreadMessageWithAddress(String walletAddress){
    List removeList = [];
    for (TLDMessageModel messageModel in this.unreadMessage) {
      if (messageModel.fromAddress == walletAddress || messageModel.toAddress == walletAddress){
        removeList.add(messageModel);
      }
    }
    for (TLDMessageModel messageModel in removeList) {
      this.unreadMessage.remove(messageModel);
    }
    if (this.unreadMessage.length == 0){
      eventBus.fire(TLDHaveUnreadMessageEvent(false));
    }
  } 

  _searchAllUnReadMessageInDB()async{
    this.unreadMessage = [];

    TLDDataBaseManager dataManager = TLDDataBaseManager();
    await dataManager.openDataBase();
    List unReadListInDB = await dataManager.searchUnReadMessageList();
    await dataManager.closeDataBase();
    this.unreadMessage.addAll(unReadListInDB);
  }

  void sendHeartMessage(){
    channel.sink.add('ping');
  }


  void sendMessage(TLDMessageModel message){
    channel.sink.add(jsonEncode(message.toJson()));
  }

  void getMsssageList(String walletAddress,int page,Function(List) success) async{
    TLDDataBaseManager manager = TLDDataBaseManager();
    await manager.openDataBase();
    if (page == 0){
      await manager.updateUnreadMessageType(walletAddress); //进入聊天界面吧未读消息设为已读
      _removeUnreadMessageWithAddress(walletAddress);
    }
    List result = await manager.searchIMDataBase(walletAddress, page);
    await manager.closeDataBase();
    success(result);
  }


  static TLDIMManager _getInstance() {
    if (_instance == null) {
      _instance = new TLDIMManager._internal();
    }
    return _instance;
  }

  
}
