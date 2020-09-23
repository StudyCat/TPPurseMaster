import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_title_input_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDAAAUserInfoPage extends StatefulWidget {
  TLDAAAUserInfoPage({Key key}) : super(key: key);

  @override
  _TLDAAAUserInfoPageState createState() => _TLDAAAUserInfoPageState();
}

class _TLDAAAUserInfoPageState extends State<TLDAAAUserInfoPage> {

  bool _loading;

  List titles = [
    '昵称',
    '手机号',
    '微信账号',
    '收款钱包'
  ];

  List placeholders = [
    '请输入昵称',
    '请输入手机号',
    '请输入微信账号',
    '请选择钱包',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _loading = false;

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'bank_card_info_page',
        transitionBetweenRoutes: false,
        middle: Text('个人信息'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _loading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: titles.length + 1,
      itemBuilder: (BuildContext context, int index){
        if (index < 3) {
          String content = '';
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TLDClipTitleInputCell(content: content,title : titles[index],placeholder: placeholders[index],textFieldEditingCallBack: (String string){

        },),
        );
        }else if( index == 3){
          return Padding(
            padding:  EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
            child: TLDClipCommonCell(type: TLDClipCommonCellType.normalArrow,title: titles[index],content: placeholders[index],titleStyle:  TextStyle(
                    fontSize: ScreenUtil().setSp(24) ,
                    color: Color.fromARGB(255, 51, 51, 51)),contentStyle: TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: ScreenUtil().setSp(24)),),
            );
        }else{
          return  Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(80)),
            child: Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(400),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            height: ScreenUtil().setHeight(80),
            width:size.width -  ScreenUtil().setWidth(200),
            child: CupertinoButton(child: Text('保存',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){ 
              
            }),
            ),
          ); 
        }
      }
    );
  }
}