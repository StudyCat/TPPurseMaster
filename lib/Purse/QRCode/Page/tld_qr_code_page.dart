import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TLDQRCodePage extends StatefulWidget {
  TLDQRCodePage({Key key,this.infoModel}) : super(key: key);

  final TLDWalletInfoModel infoModel;

  @override
  _TLDQRCodePageState createState() => _TLDQRCodePageState();
}

class _TLDQRCodePageState extends State<TLDQRCodePage> {

  String qrCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    qrCode = 'http://www.tldollar.com?walletAddress=' + widget.infoModel.walletAddress;

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'qr_code_page',
        transitionBetweenRoutes: false,
        middle: Text('收款码'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return  Container(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
        height: size.height - ScreenUtil().setHeight(170),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Container(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(24)),
            color: Colors.white,
            child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(66)),
                child: Image.asset('assetss/images/tld_icon.png',width: ScreenUtil().setWidth(236),height: ScreenUtil().setHeight(54),alignment: Alignment.center,),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                child: qrCode.length != 0  ? QrImage(data: qrCode,size : ScreenUtil().setWidth(408)) : Container(width: ScreenUtil().setWidth(408),height: ScreenUtil().setHeight(408),color: Color.fromARGB(255, 103, 103, 103),),
              ),
              Padding(
                padding: EdgeInsets.only(top : ScreenUtil().setHeight(50),left :ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
                child: getCopyAdressView(context),
              )
            ],
          ),
          ),
        ),
      );
  }


  Widget getCopyAdressView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:(){
          Clipboard.setData(ClipboardData(text : widget.infoModel.walletAddress));
                  Fluttertoast.showToast(msg: '已复制到剪切板',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      },
      child : Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Color.fromARGB(255, 230, 230, 230),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size.width - ScreenUtil().setWidth(240),
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
            child: Text(
              widget.infoModel.walletAddress,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color.fromARGB(255, 102, 102, 102)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: ScreenUtil().setWidth(50),
                bottom: ScreenUtil().setHeight(20)),
            height: ScreenUtil().setWidth(32),
            width: ScreenUtil().setWidth(32),
            child: IconButton(
                icon: Icon(
                  IconData(0xe601, fontFamily: 'appIconFonts'),
                  size: ScreenUtil().setWidth(32),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text : widget.infoModel.walletAddress));
                  Fluttertoast.showToast(msg: '已复制到剪切板',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                }),
          )
        ],
      ),
    )
    );
  }

}
