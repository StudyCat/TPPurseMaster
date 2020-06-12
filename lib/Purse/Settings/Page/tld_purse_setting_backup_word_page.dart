import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_purse_setting_backup_word_gridview.dart';
import 'tld_verify_word_page.dart';
import 'dart:convert';

enum TLDBackWordType{
  normal,
  delete
}

class TLDPurseSeetingBackWordPage extends StatefulWidget {
  TLDPurseSeetingBackWordPage({Key key,this.wallet,this.type = TLDBackWordType.normal,this.verifySuccessCallBack}) : super(key: key);

  final TLDBackWordType type;

  final TLDWallet wallet;

  final Function verifySuccessCallBack;
  @override
  _TLDPurseSeetingBackWordPageState createState() => _TLDPurseSeetingBackWordPageState();
}

class _TLDPurseSeetingBackWordPageState extends State<TLDPurseSeetingBackWordPage> {
  List _words;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _words = widget.wallet.mnemonic.split(' ');

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_setting_backup_word_page',
        transitionBetweenRoutes: false,
        middle: Text('钱包设置'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
      Size size = MediaQuery.of(context).size;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding : EdgeInsets.only(top : ScreenUtil().setHeight(140),left: ScreenUtil().setWidth(30)),
            width: size.width - ScreenUtil().setWidth(60),
            child: Text('按照下面的顺序抄下12个助记词',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),textAlign: TextAlign.center,),
          ),
          Container(
            height : ScreenUtil().setHeight(280),
            child : STDPurseSettingBackupWordGridView(words: _words,),
          ),
          Container(
            width: size.width - ScreenUtil().setWidth(200),
            margin: EdgeInsets.only(top : ScreenUtil().setHeight(80)),
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('下一步',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){
              print(_words);
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDVerifyWordPage(words: _words,type: widget.type,verifySuccessCallBack: widget.verifySuccessCallBack,)));
            }), 
          ),
        ],
      );
  }
}