
import 'dart:io';
import 'dart:typed_data';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'dart:convert' as convert;

class TLDMessageModel {
  int contentType; //  IM :(1.文本 2.图片)  系统消息：()
  String content;
  String fromAddress;
  String  toAddress;
  int id;
  bool unread;
  int createTime;
  String orderNo;
  int messageType;// 1.系统消息 2.IM

  TLDMessageModel(
      {this.contentType,
      this.content,
      this.fromAddress,
      this.toAddress,
      this.createTime,
      this.orderNo,
      this.messageType
      });

  TLDMessageModel.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    content = json['content'];
    fromAddress = json['fromAddress'];
    toAddress = json['toAddress'];
    createTime = json['createTime'];
    unread =  json['unread'] == 1 ? true : false;
    orderNo = json['orderNo'];
    messageType = json['messageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentType'] = this.contentType;
    data['content'] = this.content;
    data['fromAddress'] = this.fromAddress;
    data['toAddress'] = this.toAddress;
    data['createTime'] = this.createTime;
    data['orderNo'] = this.orderNo;
    data['messageType'] = this.messageType;
    // data['unread'] = this.unread ? 1 : 0;
    return data;
  }
}


class TLDIMManager{

  factory TLDIMManager(String walletAddress) =>_getInstance();
  static TLDIMManager get instance => _getInstance();
  static TLDIMManager _instance;

  String userToken;
  Timer timer;
  bool isOnChatPage = false;
  List unreadMessage = [];//未读消息数组
  String talkAddress = '';//聊天地址
  IOWebSocketChannel channel;
   bool isInBackState = false;

  TLDIMManager._internal() {
    // 初始化
    getUnreadMessageList();

    userToken = TLDDataManager.instance.userToken; 
  }

  Future<List> getUnreadMessageList() async {
    await _searchAllUnReadMessageInDB();
    return unreadMessage;
  }

   connectClient() async{
    if(timer != null){
      timer.cancel();
      timer = null;
    }

    channel = IOWebSocketChannel.connect("ws://192.168.1.120:8030/webSocket/"+ this.userToken);
     channel.stream.listen(( message)async { 
      if (message == 'pong'){
        return;
      }
      Map map =  convert.jsonDecode(message);
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
  _removeUnreadMessageWithOrderNo(String orderNo){
    List removeList = [];
    for (TLDMessageModel messageModel in this.unreadMessage) {
      if (messageModel.orderNo == orderNo){
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
    channel.sink.add(convert.jsonEncode(message.toJson()));
  }

  void getMsssageList(String orderNo,int page,Function(List) success) async{
    TLDDataBaseManager manager = TLDDataBaseManager();
    await manager.openDataBase();
    if (page == 0){
      await manager.updateUnreadMessageType(orderNo); //进入聊天界面吧未读消息设为已读
      _removeUnreadMessageWithOrderNo(orderNo);
    }
    List result = await manager.searchIMDataBase(orderNo, page);
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
