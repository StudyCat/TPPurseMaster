
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_tabbar_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title : '屠龙刀',
      theme: CupertinoThemeData(
        primaryColor : Color.fromARGB(255, 242, 242, 242),
        barBackgroundColor: Color.fromARGB(255, 242, 242, 242)
      ),
      home: TLDTabbarPage(),
    );
  }
}




