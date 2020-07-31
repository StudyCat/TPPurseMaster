import 'dart:io';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_title_input_cell.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_create_payment_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/View/tld_wechat_alipay_choice_qrcode_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

class TLDPaymentDiyInfoPage extends StatefulWidget {
  TLDPaymentDiyInfoPage({Key key,this.walletAddress,this.paymentModel}) : super(key: key);

  final String walletAddress;


  final TLDPaymentModel paymentModel;

  @override
  _TLDPaymentDiyInfoPageState createState() => _TLDPaymentDiyInfoPageState();
}

class _TLDPaymentDiyInfoPageState extends State<TLDPaymentDiyInfoPage> {
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
      titles = [ '自定义支付方式名称','真实姓名', '自定义支付方式账号','自定义支付收款二维码'];
      placeholders = ['请输入您的支付方式名称','请输入您的真实姓名', '请输入您的自定义支付账号','请输入您的限制额度'];
      title = '自定义支付账号信息';

    _pramaterModel.type = 4;

    if (widget.paymentModel != null){
      _pramaterModel.payId = widget.paymentModel.payId.toString();
      _pramaterModel.imageUrl = widget.paymentModel.imageUrl;
      _pramaterModel.account = widget.paymentModel.account;
      _pramaterModel.realName = widget.paymentModel.realName;
      _pramaterModel.myPayName = widget.paymentModel.myPayName;
    }
  }

   void createPayment(){
    if(_pramaterModel.myPayName.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写支付方式名称",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    
    setState(() {
      _loading = true;
    });
      _manager.createPayment(_pramaterModel, (){
        String msg =  '自定义支付添加成功';
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
    if(_pramaterModel.myPayName.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写支付方式名称",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
      _manager.updatePayment(_pramaterModel, (){
        String msg =  '自定义支付修改成功';
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
            content = _pramaterModel.myPayName;
          }else if(index == 1){
            content = _pramaterModel.realName;
          }else if(index == 2){
            content = _pramaterModel.account;
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
                    _pramaterModel.myPayName = string;
                  }else if(index == 1){
                    _pramaterModel.realName = string;
                  }else if (index == 2){
                    _pramaterModel.account = string;
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