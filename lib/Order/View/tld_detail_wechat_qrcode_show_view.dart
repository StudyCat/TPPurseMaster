import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

class TLDDetailWechatQrCodeShowView extends StatefulWidget {
  TLDDetailWechatQrCodeShowView({Key key,this.qrCode}) : super(key: key);

  final String qrCode;

  @override
  _TLDDetailWechatQrCodeShowViewState createState() => _TLDDetailWechatQrCodeShowViewState();
}

class _TLDDetailWechatQrCodeShowViewState extends State<TLDDetailWechatQrCodeShowView> {

  GlobalKey repainKey = GlobalKey();

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
        //     onPressed: (){},
        //   ),
        // ),
        // )
      ],
    ),
    );
  }

  Widget _getStackQrCodeView(){
    return Stack(
      alignment : FractionalOffset(0.5,0.30),
      children: <Widget>[
        Image.asset('assetss/images/wechat_qrcode.png',width:ScreenUtil().setWidth(584),height: ScreenUtil().setWidth(792),fit: BoxFit.fill,),
        RepaintBoundary(
          key : repainKey,
          child: QrImage(data: widget.qrCode,size :ScreenUtil().setWidth(340)),
        )
      ],
    );
  }

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          repainKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format:  ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;//这个对象就是图片数据
    } catch (e) {
      print(e);
    }
    return null;
  }
}