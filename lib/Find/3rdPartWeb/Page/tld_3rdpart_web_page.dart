import 'dart:convert';
import 'dart:math';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/3rdPartWeb/Page/tld_3rdpart_web_pay_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Purse/TransferAccounts/Model/tld_transfer_accounts_model_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
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

  bool _loading = false;

  TLDTransferAccountsModelManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TLDTransferAccountsModelManager();
  }

   void _tranferAmount(TLDTranferAmountPramaterModel pramaterModel) {
      if (pramaterModel.fromWalletAddress == null){
        Fluttertoast.showToast(msg: '请先选择支付钱包');
        return;
      }
      setState(() {
        _loading = true;
      });
    _manager.transferAmount(pramaterModel, (int txId) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }


      Fluttertoast.showToast(
      msg: '充值成功', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
      String status = _getPayStatus(200, '充值成功', '$txId');
      _payCallBackToWeb(status);
    }, (TLDError error) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
      String status = _getPayStatus(error.code, error.msg, '');
      _payCallBackToWeb(status);
    });
  }

  void _payCallBackToWeb(String status){
    _controller?.evaluateJavascript("getTransferStatus('$status')")
                ?.then((result) {
                  
    });
  }

  String _getPayStatus(int code,String mesg,String data){
    Map callBackMap = {'code':code,'msg':mesg,'data':data};
    String callBackMapStr = jsonEncode(callBackMap);
    return callBackMapStr;
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
      body: widget.urlStr.length > 0 ? LoadingOverlay(isLoading: _loading, child: _getWebWidget()) : Container(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );

  }

  Widget _getWebWidget(){
    return  WebView(
        onWebViewCreated: (contronller){
          _controller = contronller;
        },
        initialUrl : widget.urlStr,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
        _controller.evaluateJavascript('document.title').then((result){
          setState(() {
            _title = result;
          });
        }
      );
      },
      javascriptChannels: <JavascriptChannel>[
              _getPayJSChannel(),_getWithdrawJSChannel()
            ].toSet(),);
  }

  JavascriptChannel _getPayJSChannel(){
    return JavascriptChannel(
                name: "tldTransferAccount",
                onMessageReceived: (JavascriptMessage message) {
                  String mapStr = message.message;
                  Map pramater = jsonDecode(mapStr);
                  String walletAddress = pramater['walletAddress'];
                  String amount = pramater['amount'];
                  String orderInfo = pramater['orderInfo'];
                  showModalBottomSheet(context: context, isDismissible: false , builder: (context){
                    return TLD3rdPartWebPayPage(
                      amount: amount,
                      walletAddress: walletAddress,
                      orderInfo: orderInfo,
                      didClickCancelBtn: (){
                        String status = _getPayStatus(501, '用户取消支付', '');
                        _payCallBackToWeb(status);
                      },
                      didClickPayBtnCallBack: (TLDTranferAmountPramaterModel pramaterModel){
                        jugeHavePassword(context, (){
                          _tranferAmount(pramaterModel);
                        }, TLDCreatePursePageType.back, (){
                          _tranferAmount(pramaterModel);
                        });
                      },
                    );
                  });
                }
              );
  }

  JavascriptChannel _getWithdrawJSChannel(){
    return JavascriptChannel(
                name: "tldWithdraw",
                onMessageReceived: (JavascriptMessage message) {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => TLDEchangeChooseWalletPage(
                   didChooseWalletCallBack: (TLDWalletInfoModel infModel){
                     _controller?.evaluateJavascript("getWithDrawWalletAddress('${infModel.walletAddress}')")
                            ?.then((result) {
                      });
                   },
                 )));
                }
              );
  }

}