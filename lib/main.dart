import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Page/tld_purse_page.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Page/tld_my_purse_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_success_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tld_tabbar_page.dart';
import 'Purse/Settings/Page/tld_purse_setting_page.dart';
import 'Purse/Settings/Page/tld_purse_backup_word_success_page.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'CommonWidget/tld_data_manager.dart';
import 'tld_home_page.dart';
import 'dart:io';
void main(){
  final JPush jPush = JPush();

  Future<void> initPlatformState() async {

    jPush.setup(
      appKey: 'fbc4ec1832b255c5dcb7944c',
      channel: "developer-default",
      production: false,
      debug: true,
    );

     jPush.getRegistrationID().then((rid)  {
      TLDDataManager _manager = TLDDataManager.instance;
      _manager.registrationID = rid;
    });

    jPush.applyPushAuthority(
        NotificationSettingsIOS(sound: true, alert: true, badge: true)
    );

    try {

      jPush.addEventHandler(
          onReceiveNotification: (Map<String,dynamic>message) async {
            
          },
          onOpenNotification: (Map<String,dynamic>message) async {
            if (Platform.isAndroid){
            Map extras = message['extras'];
            Map dataMap = jsonDecode(extras['cn.jpush.android.EXTRA']);
            int type  = int.parse(dataMap['contentType']);
            if (type == 100 || type == 101 || type == 102 || type == 103 || type == 104){
            bool isBuyer = false;
            String buyerAddress = dataMap['buyerAddress'];
            List purseList = TLDDataManager.instance.purseList;
            List addressList = [];
            for (TLDWallet item in purseList) {
                addressList.add(item.address);
            }
            if (addressList.contains(buyerAddress)){
               isBuyer = true;
            }
              navigatorKey.currentState.push( MaterialPageRoute(builder: (context) => TLDDetailOrderPage(orderNo: dataMap['orderNo'],isBuyer: isBuyer,)));
            }else if (type == 105){
              String walletAddress = dataMap['toAddress'];
                List purseList = TLDDataManager.instance.purseList;
                TLDWallet wallet;
                for (TLDWallet item in purseList) {
                  if (item.address == walletAddress){
                    wallet = item;
                    break;
                  }
                }
              navigatorKey.currentState.push( MaterialPageRoute(builder: (context) => TLDMyPursePage(wallet: wallet,changeNameSuccessCallBack: (str){},)));
            }else if (type == 106){
              int appealId = dataMap['appealId'];
              navigatorKey.currentState.push(MaterialPageRoute(builder: (context) => TLDJustNoticePage(appealId: appealId)));
            }
          }
          }
      );
    } on Exception {
      print("---->获取平台版本失败");
    }
  }

  runApp(MyApp());

  initPlatformState();
  }

  
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TLDDataManager.instance;
    return MaterialApp(
      title : '屠龙刀',
      navigatorKey: navigatorKey,
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primaryColor : Color.fromARGB(255, 22, 128, 205),
      ),
      home: TLDHomePage(),
      // home: PlatformChannel(),
    );
  }
}






