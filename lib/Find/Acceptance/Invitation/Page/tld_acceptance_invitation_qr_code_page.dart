import 'dart:typed_data';
import 'dart:ui';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Model/tld_acceptance_invitation_qr_code_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_qr_code_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class TLDAcceptanceInvitationQRCodePage extends StatefulWidget {
  TLDAcceptanceInvitationQRCodePage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceInvitationQRCodePageState createState() => _TLDAcceptanceInvitationQRCodePageState();
}

class _TLDAcceptanceInvitationQRCodePageState extends State<TLDAcceptanceInvitationQRCodePage> with AutomaticKeepAliveClientMixin {
  TLDAcceptanceInvitationQRCodeModelManager _modelManager;

  String _qrCode = '';

  String _inviteCode = '';

  GlobalKey repainKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDAcceptanceInvitationQRCodeModelManager();
    _getQrCodeInfo();
  }

  void _getQrCodeInfo(){
    _modelManager.getQrCodeInfo((String qrCode,String inviteCode){
      setState(() {
        _qrCode = qrCode;
        _inviteCode = inviteCode;
      });
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(20), ScreenUtil().setWidth(30), ScreenUtil().setHeight(20)),
      child: Container(
        decoration: BoxDecoration(
          color : Colors.white,
          borderRadius : BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          children: <Widget>[
            RepaintBoundary(
                key : repainKey,
                child:  TLDAcceptanceInvitationQRCodeView(qrCode: _qrCode,inviteCode: _inviteCode,),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(68)),
              child: Container(
                height : ScreenUtil().setHeight(80),
                width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                child : CupertinoButton(child: Text('保存图片',style:TextStyle(color:Theme.of(context).hintColor)), padding: EdgeInsets.zero,borderRadius: BorderRadius.all(Radius.circular(4)),color: Theme.of(context).primaryColor,onPressed: ()async{
                    Uint8List bytes = await _capturePng();
                   await _saveQrCodeImage(bytes);
            }) 
              ),
            )
          ],
        ),
      ),
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
      showDialog(context: context,builder:(context){
            return TLDAlertView(title : '温馨提示',alertString:'未开启相册保存的权限，是否去开启？',type: TLDAlertViewType.normal,didClickSureBtn: (){
              openAppSettings();
            },);
      });;
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}