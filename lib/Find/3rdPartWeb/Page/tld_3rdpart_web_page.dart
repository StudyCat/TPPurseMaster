import 'dart:convert';

import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Purse/TransferAccounts/Page/tld_transfer_accounts_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TLD3rdPartWebPage extends StatefulWidget {
  TLD3rdPartWebPage({Key key,this.urlStr}) : super(key: key);

  final String urlStr;

  @override
  _TLD3rdPartWebPageState createState() => _TLD3rdPartWebPageState();
}

class _TLD3rdPartWebPageState extends State<TLD3rdPartWebPage> {

  String _title = '';

  WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'web_page',
        transitionBetweenRoutes: false,
        middle: Text(_title),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: widget.urlStr.length > 0 ?  WebView(
        onWebViewCreated: (contronller){
          _controller = contronller;
        },
        initialUrl : widget.urlStr,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
        _controller.evaluateJavascript("document.title").then((result){
          setState(() {
            _title = result;
          });
        }
      );
      },
      javascriptChannels: <JavascriptChannel>[
              JavascriptChannel(
                name: "tldTransferAccount",
                onMessageReceived: (JavascriptMessage message) {
                  String mapStr = message.message;
                  Map pramater = jsonDecode(mapStr);
                  String walletAddress = pramater['walletAddress'];
                  String amount = pramater['amount'];
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDEchangeChooseWalletPage(type: TLDEchangeChooseWalletPageType.transfer,transferAmount: amount,transferWalletAddress: walletAddress,))).then((value){
                    if (value == true){
                      _controller
                      ?.evaluateJavascript("getTransferStatus('true')")
                      ?.then((result) {
                          // You can handle JS result here.
                     });
                    }

                  });
                }
              ),
            ].toSet(),) : Container(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }



}