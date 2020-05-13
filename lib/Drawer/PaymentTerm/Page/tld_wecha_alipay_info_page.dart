import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidget/tld_clip_title_input_cell.dart';
import '../View/tld_wechat_alipay_choice_qrcode_view.dart';
import 'package:image_picker/image_picker.dart';

enum TLDWechatAliPayInfoPageType { weChat, aliPay }

class TLDWechatAliPayInfoPage extends StatefulWidget {
  TLDWechatAliPayInfoPage({Key key, @required this.type}) : super(key: key);

  final TLDWechatAliPayInfoPageType type;

  @override
  _TLDWechatAliPayInfoPageState createState() =>
      _TLDWechatAliPayInfoPageState();
}

class _TLDWechatAliPayInfoPageState extends State<TLDWechatAliPayInfoPage> {
  List titles;

  List placeholders;

  String title;

  Image _image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.type == TLDWechatAliPayInfoPageType.weChat) {
      titles = ['真实姓名', '微信账号', '微信收款二维码'];
      placeholders = ['请输入您的真实姓名', '请输入您的微信账号'];
      title = '微信账号信息';
    } else {
      titles = ['真实姓名', '支付宝账号', '支付宝收款二维码'];
      placeholders = ['请输入您的真实姓名', '请输入您的支付宝账号'];
      title = '支付宝账号信息';
    }
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
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: titles.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < titles.length - 1) {
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TLDClipTitleInputCell(
                title: titles[index],
                placeholder: placeholders[index],
                textFieldEditingCallBack: (String string) {},
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
                image: _image,
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
                  onPressed: () {}),
            );
          }
        });
  }

   /*拍照*/
  void _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
      _image = Image.file(image,width: ScreenUtil().setWidth(200),height: ScreenUtil().setHeight(200),fit: BoxFit.fill,);
    });
    }
  }

  /*相册*/
void  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery); 
    if (image != null) {
     setState(() {
      _image = Image.file(image);
    }); 
    }
  }
}

