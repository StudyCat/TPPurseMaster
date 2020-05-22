import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_export_key_address_view.dart';

class TLDExportKeyPage extends StatefulWidget {
  TLDExportKeyPage({Key key,this.wallet}) : super(key: key);

  final TLDWallet wallet;

  @override
  _TLDExportKeyPageState createState() => _TLDExportKeyPageState();
}

class _TLDExportKeyPageState extends State<TLDExportKeyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'export_key_page',
        transitionBetweenRoutes: false,
        middle: Text('导出私钥'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(150),
          ),
          child: Center(
              child: Image.asset('assetss/images/warning_copy.png',width: ScreenUtil().setWidth(218),height: ScreenUtil().setWidth(190),)),
        ),
        Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(42),
          ),
          child: Center(
              child: Text('请认真抄写，妥善保管，切勿泄漏私钥',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 208, 2, 27))),
          ),
        ),
        Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(140),
            left: ScreenUtil().setWidth(30),
          ),
          child:  Text('(我的钱包01)地址',style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(20),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)
          ),
          child: Center(
            child : TLDExportKeyAddressView(address: widget.wallet.address,),
          ),
        ),
          Container(
           padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(32),
            left: ScreenUtil().setWidth(30),
          ),
          child:  Text('(我的钱包01)私钥',style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51))),
        ),
        Container(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(20),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)
          ),
          child: Center(
            child : TLDExportKeyAddressView(privateKey: widget.wallet.privateKey,),
          ),
        )
      ],
    );
  }
}