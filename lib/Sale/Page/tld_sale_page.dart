import 'package:flutter/cupertino.dart';

class TLDSalePage extends StatefulWidget {
  TLDSalePage({Key key}) : super(key: key);

  @override
  _TLDSalePageState createState() => _TLDSalePageState();
}

class _TLDSalePageState extends State<TLDSalePage> {
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