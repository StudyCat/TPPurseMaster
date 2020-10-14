import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum TLDWebPageType{
  billDescUrl,
  cashDescUrl,
  inviteProfitDescUrl,
  overflowProfitDescUrl,
  profitDescUrl,
  tldWalletAgreement,
  orderDescUrl,
  playDescUrl,
  transferOutUrl,
  aaaUrl,
  ylbDescUrl
}

class TLDWebPage extends StatefulWidget {
  TLDWebPage({Key key,this.title,this.type,this.urlStr = ''}) : super(key: key);

  final TLDWebPageType type;

  final String title;

  final String urlStr;

  @override
  _TLDWebPageState createState() => _TLDWebPageState();
}

class _TLDWebPageState extends State<TLDWebPage> {

  @override
  void initState() { 
    super.initState();
    _getBaseUrl();
  }

  String _url = '';

  void _getBaseUrl(){
    TLDBaseRequest request = TLDBaseRequest({},'common/tldPlayDesc');
    request.postNetRequest((value) {
      String url = '';
      if (widget.type == TLDWebPageType.billDescUrl) {
        url = value['billDescUrl'];
      }else if(widget.type == TLDWebPageType.cashDescUrl){
        url = value['cashDescUrl'];
      }else if(widget.type == TLDWebPageType.inviteProfitDescUrl){
        url = value['inviteProfitDescUrl'];
      }else if(widget.type == TLDWebPageType.overflowProfitDescUrl){
        url = value['overflowProfitDescUrl'];
      }else if(widget.type == TLDWebPageType.profitDescUrl){
        url = value['profitDescUrl'];
      }else if(widget.type == TLDWebPageType.tldWalletAgreement){
        url = value['tldWalletAgreement'];
      }else if(widget.type == TLDWebPageType.orderDescUrl){
        url = value['orderDescUrl'];
      }else if(widget.type == TLDWebPageType.playDescUrl){
         url = value['playDescUrl'];
      }else if(widget.type == TLDWebPageType.transferOutUrl){
        url = value['transferOutUrl'];
      }else if(widget.type == TLDWebPageType.aaaUrl){
        url = value['aaaUrl'];
      }else if(widget.type == TLDWebPageType.ylbDescUrl){
        url = value['ylbDescUrl'];
      }
      if (mounted) {
        setState(() {
          _url = url;
        });
      }
    }, (TLDError error){
      
    });
  }

  @override
  Widget build(BuildContext context) {
    String urlStr = '';
    if (widget.urlStr.length > 0) {
      urlStr = widget.urlStr;
    }else{
      urlStr = _url;
    }
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
      body: urlStr.length > 0 ?  WebView(
        initialUrl : urlStr,
        javascriptMode: JavascriptMode.unrestricted,
      ) : Container(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }
}