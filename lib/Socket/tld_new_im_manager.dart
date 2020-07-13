import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:platform/platform.dart';

class TLDNewMessageModel{
  String text;
  File imageFile;
  int contentType;//1.文本 2.图片
  String toUserName;
}

MethodChannel channel = MethodChannel('jmessage_flutter');

/// 极光 IM 初始化
JmessageFlutter JMessage = new JmessageFlutter.private(channel, const LocalPlatform());

class TLDNewIMManager{
    void init() {
     JMessage.init(isOpenMessageRoaming: true, appkey:'fbc4ec1832b255c5dcb7944c');

      JMessage.setDebugMode(enable: true);
    }

    Future<bool> loginJpush(String userName,String password) async {
      JMUserInfo userInfo = await JMessage.login(username: userName, password: password);
      if (userInfo != null){
        return true;
      }else{
        return false;
      }
    }

    void getReciveeMessageCallBack(String userName ,Function(dynamic) receiveMessageCallBack) async{
      await getConversation(userName);
      JMSingle single = JMSingle.fromJson({'username':userName,'appKey':'fbc4ec1832b255c5dcb7944c'});
      await JMessage.enterConversation(target: single);
      JMessage.addReceiveMessageListener((message) {
        JMNormalMessage normalMessage = message;
        JMUserInfo formUserInfo = normalMessage.from;
        if (formUserInfo.username == userName){
          receiveMessageCallBack(message);
        } 
      });
    }

    void removeRecieveMessageCallBack(String userName)async {
      JMSingle single = JMSingle.fromJson({'username':userName,'appKey':'fbc4ec1832b255c5dcb7944c'});
      await JMessage.exitConversation(target: single);
      JMessage.removeReceiveMessageListener((message) {
        
      });
    }

    void getHistoryMessage(String userName,int pageFrom,Function(List) success)async {
      JMSingle single = JMSingle.fromJson({'username':userName,'appKey':'fbc4ec1832b255c5dcb7944c'});
      List result = await JMessage.getHistoryMessages(type: single, from: pageFrom, limit: 10,isDescend: false);
      success(result);
    }

    Future<dynamic> sendMessage(TLDNewMessageModel messageModel) async{
      JMMessageType messageType;
      var message;
      JMSingle single = JMSingle.fromJson({'username':messageModel.toUserName,'appKey':'fbc4ec1832b255c5dcb7944c'});
      if (messageModel.contentType == 1){
        messageType = JMMessageType.text;
        message = await JMessage.createMessage(type: messageType, targetType: single,text: messageModel.text);
      }else{
        messageType = JMMessageType.image;
        message = await JMessage.createMessage(type: messageType, targetType: single,path: messageModel.imageFile.path);
      }
      var sendMessage = await JMessage.sendMessage(message: message,
        sendOption: JMMessageSendOptions.fromJson({
              'isShowNotification': true, 
              'isRetainOffline': true,
            }));
      return sendMessage;
    }

    Future getConversation(String userName) async{
       JMSingle single = JMSingle.fromJson({'username': userName,'appKey':'fbc4ec1832b255c5dcb7944c'});
      List dataList = await JMessage.getConversations();
      for (JMConversationInfo item in dataList) {
        JMUserInfo userInfo = item.target; 
        if (userInfo.username == userName){
          await JMessage.enterConversation(target: single);
          return;
        }
      }
      await JMessage.createConversation(target: single);
      await JMessage.enterConversation(target: single);
    }

    Future<List> getMessageConversationList()async{
      List dataList = await JMessage.getConversations();
      List resultList = [];
      for (JMConversationInfo item in dataList) {
        if (item.latestMessage != null){
          resultList.add(item);
        }
      }
      return resultList;
    }

    Future<String> downloadImage(String messageId,String userName) async{
       JMSingle single = JMSingle.fromJson({'username': userName,'appKey':'fbc4ec1832b255c5dcb7944c'});
      Map map = await JMessage.downloadThumbImage(target: single, messageId: messageId);
      return map['filePath'];
    } 
}