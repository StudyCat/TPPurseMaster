import 'package:flutter/cupertino.dart';

class TLDPursePage extends StatefulWidget {
  TLDPursePage({Key key}) : super(key: key);

  @override
  _TLDPursePageState createState() => _TLDPursePageState();
}

class _TLDPursePageState extends State<TLDPursePage> {
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