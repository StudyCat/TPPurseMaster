import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../View/tld_transfer_accounts_normal_row_view.dart';
import '../View/tld_transfer_accounts_input_row_view.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:async';

class TLDTransferAccountsPage extends StatefulWidget {
  TLDTransferAccountsPage({Key key}) : super(key: key);

  @override
  _TLDTransferAccountsPageState createState() => _TLDTransferAccountsPageState();
}

class _TLDTransferAccountsPageState extends State<TLDTransferAccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'transfer_accounts_page',
        transitionBetweenRoutes: false,
        middle: Text('转账'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
        height: size.height - ScreenUtil().setHeight(170),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Container(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(24),right : ScreenUtil().setWidth(24)),
            color: Colors.white,
            child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children : <Widget>[
              TLDTransferAccountsNormalRowView(title: '数量',content: '当前钱包余额：1000TLD',),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                child: TLDTransferAccountsInputRowView(type : TLDTransferAccountsInputRowViewType.allTransfer),
              ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                child: _getTitleLabel('发送地址'),
              ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                child: TLDTransferAccountsInputRowView(type : TLDTransferAccountsInputRowViewType.normal,
              ), ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                child: _getTitleLabel('接收地址'),
              ),
               Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                child: TLDTransferAccountsInputRowView(type : TLDTransferAccountsInputRowViewType.scanCode,didClickScanBtnCallBack: (){
                  _scanPhoto();
                },
              ), ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setWidth(20)),
                child: TLDTransferAccountsNormalRowView(title: '手续费率',content: '0.6%',),
              ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setWidth(20)),
                child: TLDTransferAccountsNormalRowView(title: '手续费',content: '¥6',),
              ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(200),),
                child: Container(
                  width: size.width - ScreenUtil().setWidth(108),
                  height: ScreenUtil().setHeight(96),
                  child : CupertinoButton(child: Text('确定'), color: Theme.of(context).primaryColor,onPressed: (){})
                ),
              )
              ]
          ),
          ),
        ),
      ),
    );
  }

  Widget _getTitleLabel(String title){
    return Text(title,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),);
  }

  Future _scanPhoto() async {
    String barcode = await  scanner.scan();
  }

}