
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../View/tld_my_purse_header.dart';
import '../View/tld_my_purse_content_view.dart';

class TLDMyPursePage extends StatefulWidget {
  TLDMyPursePage({Key key}) : super(key: key);

  @override
  _TLDMyPursePageState createState() => _TLDMyPursePageState();
}

class _TLDMyPursePageState extends State<TLDMyPursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CupertinoNavigationBar(
         middle: Text('data'),
         backgroundColor: Color.fromARGB(255, 242, 242, 242),
         actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
       ),
       body: _getBodyWidget(context),
       backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return Column(
      children : <Widget>[
        TLDMyPurseHeaderView(),
        Expanded(
          child: TLDMyPurseContentView(),
        )
      ]
    );
  }
}