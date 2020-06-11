import 'package:dragon_sword_purse/Purse/FirstPage/Page/tld_purse_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_success_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'tld_tabbar_page.dart';
import 'Purse/Settings/Page/tld_purse_setting_page.dart';
import 'Purse/Settings/Page/tld_purse_backup_word_success_page.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'CommonWidget/tld_data_manager.dart';
import 'tld_home_page.dart';

void main(){
  final JPush jPush = JPush();

  Future<void> initPlatformState() async {

    jPush.getRegistrationID().then((rid) {
      print('---->rid:${rid}');
    });

    jPush.setup(
      appKey: 'fbc4ec1832b255c5dcb7944c',
      channel: "developer-default",
      production: false,
      debug: true,
    );

    jPush.applyPushAuthority(
        NotificationSettingsIOS(sound: true, alert: true, badge: true)
    );

    try {

      jPush.addEventHandler(
          onReceiveNotification: (Map<String,dynamic>message) async {
            print('---->接收到推送:${message}');
          }
      );
    } on Exception {
      print("---->获取平台版本失败");
    }
  }

  runApp(MyApp());

  initPlatformState();
  }

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TLDDataManager.instance;
    return MaterialApp(
      title : '屠龙刀',
      theme: ThemeData(
        primaryColor : Color.fromARGB(255, 22, 128, 205),
      ),
      home: TLDHomePage(),
      // home: PlatformChannel(),
    );
  }
}






