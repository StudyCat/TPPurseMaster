import 'package:dragon_sword_purse/Purse/FirstPage/Page/tld_purse_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_success_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_tabbar_page.dart';
import 'Purse/Settings/Page/tld_purse_setting_page.dart';
import 'Purse/Settings/Page/tld_purse_backup_word_success_page.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'CommonWidget/tld_data_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TLDDataManager.instance;
    return MaterialApp(
      title : '屠龙刀',
      theme: ThemeData(
        primaryColor : Color.fromARGB(255, 51, 114, 245),
      ),
      home: TLDTabbarPage(),
      // home: PlatformChannel(),
    );
  }
}






