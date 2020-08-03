import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Model/tld_acceptance_login_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/View/tld_acceptance_scan_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/TabbarPage/Page/tld_acceptance_tabbar_page.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

class TLDAcceptanceInviteLoginPage extends StatefulWidget {
  TLDAcceptanceInviteLoginPage({Key key,this.pramater}) : super(key: key);

  final TLDAcceptanceLoginPramater pramater;

  @override
  _TLDAcceptanceInviteLoginPageState createState() => _TLDAcceptanceInviteLoginPageState();
}

class _TLDAcceptanceInviteLoginPageState extends State<TLDAcceptanceInviteLoginPage> {

bool _isLoading = false;

TLDAcceptanceLoginModelManager _manager;

TextEditingController _inviteController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _inviteController = TextEditingController();

    _manager = TLDAcceptanceLoginModelManager();
  }


void _loginUser(){
    if (widget.pramater.inviteCode == null){
      Fluttertoast.showToast(msg: '请填写推广码');
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    _manager.loginWithPramater(widget.pramater, (String token){
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context)..pop()..pop();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceTabbarPage()));
    }, (TLDError error){
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_invite_login_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD票据账户登记'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }



   Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index){
        if (index == 0){
           return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TLDAcceptanceScanCell(title : '推荐码',placeholder: '请输入您的推荐码',inviteController: _inviteController,
          didClickScanButtonCallBack: ()async{
            await _scanPhoto();
          },
          textDidChangeCallBack: (String text){
            widget.pramater.inviteCode = text;
          },
          ));
        }else{
          return Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(400),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            height: ScreenUtil().setHeight(80),
            width:size.width -  ScreenUtil().setWidth(200),
            child: CupertinoButton(child: Text('登记',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){ 
              _loginUser();
            }),
          );
        }
      }
    );
  }

   Future _scanPhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted ||
        status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TLDScanQrCodePage(
                  scanCallBack: (String result) {
                    _manager.getInvationCodeFromQrCode(result,
                        (String inviteCode) {
                      _inviteController.text = inviteCode;
                      widget.pramater.inviteCode = inviteCode;
                    }, (TLDError error) {
                      Fluttertoast.showToast(
                          msg: error.msg,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1);
                    });
                  },
                )));
  }
}