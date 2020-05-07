import 'package:flutter/cupertino.dart';

class TLDExchangePage extends StatefulWidget {
  TLDExchangePage({Key key}) : super(key: key);

  @override
  _TLDExchangePageState createState() => _TLDExchangePageState();
}

class _TLDExchangePageState extends State<TLDExchangePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(),
      navigationBar: CupertinoNavigationBar(
        middle: Text('......'),
      ),
      );
  }
}