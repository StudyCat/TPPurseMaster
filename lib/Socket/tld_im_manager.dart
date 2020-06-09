
import 'dart:async';
import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Notification/tld_im_message_notification.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;


class TLDMessageModel {
  int contentType;
  String content;
  String fromAddress;
  String  toAddress;
  int id;

  TLDMessageModel(
      {this.contentType,
      this.content,
      this.fromAddress,
      this.toAddress,
      });

  TLDMessageModel.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    content = json['content'];
    fromAddress = json['fromAddress'];
    toAddress = json['toAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentType'] = this.contentType;
    data['content'] = this.content;
    data['fromAddress'] = this.fromAddress;
    data['toAddress'] = this.toAddress;
    return data;
  }
}


class TLDIMManager{

  factory TLDIMManager(String walletAddress) =>_getInstance();
  static TLDIMManager get instance => _getInstance();
  static TLDIMManager _instance;

  String walletAddress;
  Timer timer;
   
  IOWebSocketChannel channel;
  Function(List) listenMessageCallBack;


  TLDIMManager._internal() {
    // 初始化

  }

   connectClient() async{
    if(timer != null){
      timer.cancel();
      timer = null;
    }
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
        for (Map item in messageList) {
          TLDMessageModel messageModel = TLDMessageModel.fromJson(item);
          result.add(messageModel); 
        }
        TLDDataBaseManager dataManager = TLDDataBaseManager();
        await dataManager.openIMDataBase();
        await dataManager.insertIMDataBase(result);
        await dataManager.close();
        if(this.listenMessageCallBack != null){
          this.listenMessageCallBack(result);
        }
      }
      
    },onError: (error){
      connectClient();
    });
    timer = Timer.periodic(Duration(seconds : 30), (timer) { 
      sendHeartMessage();
    });
  }

 

  void sendHeartMessage(){
    channel.sink.add('ping');
  }


  void sendMessage(TLDMessageModel message){
    channel.sink.add(jsonEncode(message.toJson()));
  }

  void getMsssageList(String walletAddress,int page,Function(List) success) async{
    TLDDataBaseManager manager = TLDDataBaseManager();
    await manager.openIMDataBase();
    List result = await manager.searchIMDataBase(walletAddress, page);
    await manager.close();
    success(result);
  }


  static TLDIMManager _getInstance() {
    if (_instance == null) {
      _instance = new TLDIMManager._internal();
    }
    return _instance;
  }

  
  }
