import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidget/tld_clip_input_cell.dart';
import '../View/tld_verify_password_view.dart';
import 'tld_creating_purse_page.dart';

class TLDCreatePursePage extends StatefulWidget {
  TLDCreatePursePage({Key key}) : super(key: key);

  @override
  _TLDCreatePursePageState createState() => _TLDCreatePursePageState();
}

class _TLDCreatePursePageState extends State<TLDCreatePursePage> {

  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'create_purse_page',
        transitionBetweenRoutes: false,
        middle: Text('创建钱包'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        child: _getBodyWidget(context),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(40),left : ScreenUtil().setWidth(30)),
          child: Text('请设置安全密码',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),),
        ),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
          child: Center(
            child : TLDClipInputCell(placeholder: '请输入您的密码',textFieldEditingCallBack: (String string){
              setState(() {
                _password = string;      
              });
            },) 
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),left : ScreenUtil().setWidth(30)),
          child: Text('确认密码',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),),
        ),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
          child: Center(
            child : TLDClipInputCell(placeholder: '请再次输入您的密码',textFieldEditingCallBack: (String string){
            },) 
          ),
        ),
        Container(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
          width: size.width,
          child: TLDVerifyPasswordView(password: _password,),
        ),
       Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(150),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            height: ScreenUtil().setHeight(80),
            width:size.width -  ScreenUtil().setWidth(200),
            child: CupertinoButton(child: Text('确定',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){ 
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDCreatingPursePage()));
            }),
          ) 
      ],
    );
  }
}