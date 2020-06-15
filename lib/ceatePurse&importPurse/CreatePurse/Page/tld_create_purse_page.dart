import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../CommonWidget/tld_clip_input_cell.dart';
import '../View/tld_verify_password_view.dart';
import 'tld_creating_purse_page.dart';
import '../Model/create_purse_model_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../CommonWidget/tld_data_manager.dart';

enum TLDCreatePursePageType{
  create,
  import,
  back
}

class TLDCreatePursePage extends StatefulWidget {
  TLDCreatePursePage({Key key,@required this.type,this.setPasswordSuccessCallBack}) : super(key: key);

  final TLDCreatePursePageType type;

  final Function setPasswordSuccessCallBack;

  @override
  _TLDCreatePursePageState createState() => _TLDCreatePursePageState();
}

class _TLDCreatePursePageState extends State<TLDCreatePursePage> {
  String _password;

  String _surePassword;

  TLDCreatePurseModelManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _manager = TLDCreatePurseModelManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'create_purse_page',
        transitionBetweenRoutes: false,
        middle: Text('设置安全密码'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        child: _getBodyWidget(context),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(40), left: ScreenUtil().setWidth(30)),
          child: Text(
            '请设置安全密码',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color.fromARGB(255, 51, 51, 51)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setWidth(30)),
          child: Center(
              child: TLDClipInputCell(
            placeholder: '请输入您的密码',
            isNeedSecretShow: true,
            textFieldEditingCallBack: (String string) {
              setState(() {
                _password = string;
              });
            },
          )),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(32), left: ScreenUtil().setWidth(30)),
          child: Text(
            '确认密码',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Color.fromARGB(255, 51, 51, 51)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setWidth(30)),
          child: Center(
              child: TLDClipInputCell(
            placeholder: '请再次输入您的密码',
            isNeedSecretShow: true,
            textFieldEditingCallBack: (String string) {
              _surePassword = string;
            },
          )),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(32),
              left: ScreenUtil().setWidth(30),
              right: ScreenUtil().setWidth(30)),
          width: size.width,
          child: TLDVerifyPasswordView(
            password: _password,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(150),
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
                if (_isHaveCapital() &&
                    _isHaveLowercase() &&
                    _isHaveNum() &&
                    _isLengthLegal()) {
                  if (_password == _surePassword) {
                    _registerUser();
                  } else {
                    Fluttertoast.showToast(
                        msg: "确认密码与密码不符合",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                  }
                } else {
                  Fluttertoast.showToast(
                      msg: "不符合密码强度",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                }
              }),
        )
      ],
    );
  }

  void _registerUser(){
    _manager.createSafeSecretPasswordRegisterUser((){
      _savePassword();
      if (widget.type == TLDCreatePursePageType.create){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TLDCreatingPursePage(type: TLDCreatingPursePageType.create,)));
      }else if (widget.type == TLDCreatePursePageType.import){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TLDImportPursePage()));
      }else {
          if (widget.setPasswordSuccessCallBack != null){
                widget.setPasswordSuccessCallBack();
          }
          Navigator.pop(context);
      }
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _savePassword() async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('password', _password);
    TLDDataManager.instance.password = _password;
  }

  bool _isHaveCapital() {
    if (_password == null) {
      return false;
    }
    return RegExp(r"[A-Z]").hasMatch(_password);
  }

  bool _isHaveLowercase() {
    if (_password == null) {
      return false;
    }
    return RegExp(r"[a-z]").hasMatch(_password);
  }

  bool _isHaveNum() {
    if (_password == null) {
      return false;
    }
    return RegExp(r"[0-9]").hasMatch(_password);
  }

  bool _isLengthLegal() {
    if (_password == null) {
      return false;
    }
    return (_password.length > 7 && _password.length < 33);
  }
}
