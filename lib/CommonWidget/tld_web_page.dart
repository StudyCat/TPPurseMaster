import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class TLDWebPage extends StatefulWidget {
  TLDWebPage({Key key,this.title,this.urlStr}) : super(key: key);


  final String urlStr;

  final String title;

  @override
  _TLDWebPageState createState() => _TLDWebPageState();
}

class _TLDWebPageState extends State<TLDWebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'web_page',
        transitionBetweenRoutes: false,
        middle: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: WebView(
        initialUrl : widget.urlStr,
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }
}