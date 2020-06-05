import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class TLDDetailAlipayQrCodeShowView extends StatefulWidget {
  TLDDetailAlipayQrCodeShowView({Key key,this.qrCode}) : super(key: key);

  final String qrCode;

  @override
  _TLDDetailAlipayQrCodeShowViewState createState() => _TLDDetailAlipayQrCodeShowViewState();
}

class _TLDDetailAlipayQrCodeShowViewState extends State<TLDDetailAlipayQrCodeShowView> {

  GlobalKey repainKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(150)),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _getStackQrCodeView(),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(60)),
          child: Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(480),
          child: CupertinoButton(
            color: Colors.white,
            child: Text('保存二维码',style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28)),),
            onPressed: ()async{
              Uint8List bytes = await _capturePng();
              await _saveQrCodeImage(bytes);
            },
          ),
        ),
        )
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

  Future _saveQrCodeImage(Uint8List bytes) async{
    // Map<PermissionStatusGetters>
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied) {
      Fluttertoast.showToast(msg: '请先设置相册保存权限',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      return;
    }
    var result = await ImageGallerySaver.saveImage(bytes);
    if (result != null){
      Fluttertoast.showToast(msg: '保存二维码成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    }else{
      Fluttertoast.showToast(msg: '保存二维码失败',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    }
  }
}