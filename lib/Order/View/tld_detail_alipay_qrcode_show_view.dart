import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TLDDetailAlipayQrCodeShowView extends StatefulWidget {
  TLDDetailAlipayQrCodeShowView({Key key,this.qrCode}) : super(key: key);

  final String qrCode;

  @override
  _TLDDetailAlipayQrCodeShowViewState createState() => _TLDDetailAlipayQrCodeShowViewState();
}

class _TLDDetailAlipayQrCodeShowViewState extends State<TLDDetailAlipayQrCodeShowView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(150)),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _getStackQrCodeView(),
        // Padding(
        //   padding: EdgeInsets.only(top : ScreenUtil().setHeight(60)),
        //   child: Container(
        //   height: ScreenUtil().setHeight(80),
        //   width: ScreenUtil().setWidth(480),
        //   child: CupertinoButton(
        //     color: Colors.white,
        //     child: Text('保存二维码',style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28)),),
        //     onPressed: (){

        //     },
        //   ),
        // ),
        // )
      ],
    ),
    );
  }

  Widget _getStackQrCodeView(){
    return Stack(
      alignment : FractionalOffset(0.5,0.6),
      children: <Widget>[
        Image.asset('assetss/images/alipay_qrcode.png',width:ScreenUtil().setWidth(584),height: ScreenUtil().setWidth(910),fit: BoxFit.fill,),
        QrImage(data: widget.qrCode,size :ScreenUtil().setWidth(340)),
      ],
    );
  }
}