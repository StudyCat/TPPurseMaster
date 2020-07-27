
import 'dart:io';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../CommonWidget/tld_clip_title_input_cell.dart';
import '../View/tld_wechat_alipay_choice_qrcode_view.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/tld_create_payment_model_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';

enum TLDWechatAliPayInfoPageType { weChat, aliPay }

class TLDWechatAliPayInfoPage extends StatefulWidget {
  TLDWechatAliPayInfoPage({Key key, @required this.type,this.walletAddress,this.paymentModel}) : super(key: key);

  final String walletAddress;

  final TLDWechatAliPayInfoPageType type;

  final TLDPaymentModel paymentModel;

  @override
  _TLDWechatAliPayInfoPageState createState() =>
      _TLDWechatAliPayInfoPageState();
}

class _TLDWechatAliPayInfoPageState extends State<TLDWechatAliPayInfoPage> {
  List titles;

  List placeholders;

  String title;

  TLDCreatePaymentPramaterModel _pramaterModel;

  TLDCreatePaymentModelManager _manager;

  bool _loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loading = false;
    _manager = TLDCreatePaymentModelManager();

    _pramaterModel = TLDCreatePaymentPramaterModel();
    _pramaterModel.walletAddress = widget.walletAddress;
    if (widget.type == TLDWechatAliPayInfoPageType.weChat) {
      titles = ['真实姓名', '微信账号', '限额（每日）','微信收款二维码'];
      placeholders = ['请输入您的真实姓名', '请输入您的微信账号','请输入您的限制额度'];
      title = '微信账号信息';

    _pramaterModel.type = 2;
    } else {
      titles = ['真实姓名', '支付宝账号', '限额（每日）','支付宝收款二维码'];
      placeholders = ['请输入您的真实姓名', '请输入您的支付宝账号','请输入您的限制额度'];
      title = '支付宝账号信息';

      _pramaterModel.type = 3;
    }

    if (widget.paymentModel != null){
      _pramaterModel.payId = widget.paymentModel.payId.toString();
      _pramaterModel.imageUrl = widget.paymentModel.imageUrl;
      _pramaterModel.account = widget.paymentModel.account;
      _pramaterModel.realName = widget.paymentModel.realName;
      _pramaterModel.quota = widget.paymentModel.quota;
    }
  }

   void createPayment(){
    if(_pramaterModel.realName.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写真实姓名",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.account.length == 0){
      String msg = widget.type == TLDWechatAliPayInfoPageType.weChat ? '请填写微信账号' : '请填写支付宝账号';
      Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.quota.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写每日限额",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.imageUrl.length == 0){
      Fluttertoast.showToast(
                      msg: "请添加付款码",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    
    setState(() {
      _loading = true;
    });
      _manager.createPayment(_pramaterModel, (){
        String msg = widget.type == TLDWechatAliPayInfoPageType.weChat ? '添加微信号成功' : '添加支付宝成功';
        Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
        Navigator.of(context).pop();
      }, (TLDError error){
      if (mounted){
      setState(() {
        _loading = false;
      });
      }
      Fluttertoast.showToast(
                      msg: error.msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
    });
  }

  void updatePayment(){
    if(_pramaterModel.realName.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写真实姓名",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
      _manager.updatePayment(_pramaterModel, (){
        String msg = widget.type == TLDWechatAliPayInfoPageType.weChat ? '修改微信号成功' : '修改支付宝成功';
        Fluttertoast.showToast(
                      msg: msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
        Navigator.of(context).pop();
      }, (TLDError error){
      if (mounted){
        setState(() {
        _loading = false;
      });
      }
      Fluttertoast.showToast(
                      msg: error.msg,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'wechat_alipay_info_page',
        transitionBetweenRoutes: false,
        middle: Text(title),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _loading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: titles.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < titles.length - 1) {
          String content;
          if(index == 0){
            content = _pramaterModel.realName;
          }else if(index == 1){
            content = _pramaterModel.account;
          }else if(index == 2){
            content = _pramaterModel.quota;
          }
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TLDClipTitleInputCell(
                content: content,
                title: titles[index],
                placeholder: placeholders[index],
                textFieldEditingCallBack: (String string) {
                  if (index == 0){
                    _pramaterModel.realName = string;
                  }else if(index == 1){
                    _pramaterModel.account = string;
                  }else if (index == 2){
                    _pramaterModel.quota = string;
                  } 
                },
              ),
            );
          }else if (index == titles.length - 1){
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TLDWechatAlipayChoiceQRCodeView(
                title: titles[index],
                imageUrl: _pramaterModel.imageUrl,
                didClickBtnCallBack: (){
                  showCupertinoModalPopup(context: context,builder : (BuildContext context){
                    return CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoButton(child: Text('拍摄'), onPressed: (){
                          _takePhoto();
                          Navigator.of(context).pop();
                        }),
                        CupertinoButton(child: Text('从相册选择'), onPressed: (){
                          _openGallery();
                          Navigator.of(context).pop();
                        }),
                      ],
                      cancelButton: CupertinoButton(child: Text('取消'), onPressed: (){
                        Navigator.of(context).pop();
                      }),
                    );
                  });
                },
              ),
            );
          }else {
            return Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(400),
                  left: ScreenUtil().setWidth(100),
                  right: ScreenUtil().setWidth(100)),
              height: ScreenUtil().setHeight(80),
              width: size.width - ScreenUtil().setWidth(200),
              child: CupertinoButton(
                  child: Text(
                    '确定',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(28), color: Colors.white),
                  ),
                  padding: EdgeInsets.all(0),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_pramaterModel.payId.length == 0){
                      createPayment();
                    }else{
                      updatePayment();
                    }
                  }),
            );
          }
        });
  }

   /*拍照*/
  void _takePhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }

    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    final String data = await FlutterQrReader.imgScan(image);
    if (data == null){
      Fluttertoast.showToast(msg: '该图片不是二维码');
      return;
    }else{
       setState(() {
        _pramaterModel.imageUrl = data;
    });
  }
  }

  /*相册*/
void  _openGallery() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied || status == PermissionStatus.restricted|| status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }
    File image = await ImagePicker.pickImage(source: ImageSource.gallery); 
    final String data = await FlutterQrReader.imgScan(image);
    if (data == null){
      Fluttertoast.showToast(msg: '该图片不是二维码');
      return;
    }else{
       setState(() {
        _pramaterModel.imageUrl = data;
    });
    }
}

}