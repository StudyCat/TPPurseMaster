
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_tabbar_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : '屠龙刀',
      theme: ThemeData(
        primaryColor : Color.fromARGB(255, 242, 242, 242),
      ),
      home: TLDTabbarPage(),
    );
  }
}



