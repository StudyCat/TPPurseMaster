import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../View/tld_my_purse_header.dart';
import '../View/tld_my_purse_content_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Settings/Page/tld_purse_setting_page.dart';
import '../../TransferAccounts/Page/tld_transfer_accounts_page.dart';
import '../../QRCode/Page/tld_qr_code_page.dart';
import '../../FirstPage/Model/tld_wallet_info_model.dart';

class TLDMyPursePage extends StatefulWidget {
  TLDMyPursePage({Key key,this.infoModel,this.changeNameSuccessCallBack}) : super(key: key);

  final TLDWalletInfoModel infoModel;

  final ValueChanged<String> changeNameSuccessCallBack;

  @override
  _TLDMyPursePageState createState() => _TLDMyPursePageState();
}

class _TLDMyPursePageState extends State<TLDMyPursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'my_purse_page',
        transitionBetweenRoutes: false,
        middle: Text(widget.infoModel.wallet.name),
        trailing: Container(
            width: ScreenUtil().setWidth(160),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                    child: Icon(
                      IconData(0xe663, fontFamily: 'appIconFonts'),
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }),
                CupertinoButton(
                    child: Icon(
                      IconData(0xe615, fontFamily: 'appIconFonts'),
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TLDPurseSettingPage(wallet : widget.infoModel.wallet,nameChangeSuccessCallBack: (String name){
                              widget.changeNameSuccessCallBack(name);
                              setState(() {
                                widget.infoModel.wallet.name = name;
                              });
                            },);
                          },
                        ),
                      );
                    }),
              ],
            )),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return Column(children: <Widget>[
      TLDMyPurseHeaderView(infoModel: widget.infoModel,didClickTransferAccountsBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDTransferAccountsPage(walletInfoModel: widget.infoModel,transferSuccessCallBack: (String str){
          setState(() {
            widget.infoModel.value = (double.parse(widget.infoModel.value) - double.parse(str)).toString();
          });
        },)));
      },
      didClickChangeBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDExchangePage(infoModel: widget.infoModel,)));
      },
      didClickQRCodeBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDQRCodePage(infoModel: widget.infoModel,)));
      },
      ),
      Expanded(
        child: TLDMyPurseContentView(walletAddress: widget.infoModel.walletAddress,),
      )
    ]);
  }
}
