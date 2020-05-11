
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_tabbar_page.dart';
import 'Purse/Settings/Page/tld_purse_setting_page.dart';
import 'Purse/Settings/Page/tld_purse_backup_word_success_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : '屠龙刀',
      theme: ThemeData(
        primaryColor : Color.fromARGB(255, 51, 114, 245),
      ),
      home: TLDTabbarPage(),
       routes: <String,WidgetBuilder>{
        "/purse_setting":(BuildContext context)=>new TLDPurseSettingPage(),
        '/purse_backup_word_success' :(BuildContext context)=>new TLDPurseBackupWordSuccessPage()
      },
    );
  }
}



