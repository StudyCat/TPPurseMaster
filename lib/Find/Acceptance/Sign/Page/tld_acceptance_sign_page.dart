import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_body_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_header_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceSignPage extends StatefulWidget {
  TLDAcceptanceSignPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceSignPageState createState() => _TLDAcceptanceSignPageState();
}

class _TLDAcceptanceSignPageState extends State<TLDAcceptanceSignPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_sign_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑账户'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return Column(
      children: <Widget>[
        TLDAcceptanceSignHeaderView(),
        TLDAcceptanceSignBodyView()
      ],
    );
  }

}