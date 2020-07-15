import 'package:dragon_sword_purse/CommonWidget/tld_clip_title_input_cell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_normalCell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/View/tld_acceptance_login_code_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/View/tld_acceptance_scan_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDAcceptanceLoginPage extends StatefulWidget {
  TLDAcceptanceLoginPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceLoginPageState createState() => _TLDAcceptanceLoginPageState();
}

class _TLDAcceptanceLoginPageState extends State<TLDAcceptanceLoginPage> {
  bool _isLoading = false;

  
  List titles = [
    '手机号',
    '验证码',
    '推荐人ID',
    '钱包地址'
  ];

  List placeholders = [
    '请输入您的手机号',
    '请输入验证码',
    '请输入您的推荐人ID',
    '您的钱包地址'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_login_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑账户登记'),
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
      itemCount: titles.length + 1,
      itemBuilder: (BuildContext context, int index){
        if (index == 0) {
          String content = '';
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TLDClipTitleInputCell(content: content,title : titles[index],placeholder: placeholders[index],textFieldEditingCallBack: (String string){
        },),
        );
        }else if(index == 1){
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TLDAcceptanceLoginCodeCell(title : titles[index],placeholder: placeholders[index],),);
        }else if (index == 2){
           return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TLDAcceptanceScanCell(title : titles[index],placeholder: placeholders[index],),);
        }else if(index == 3){
          return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normalArrow,
            title: titles[index],
            content:  '选择钱包',
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: ScreenUtil().setSp(2),
            didClickCallBack: () {
            },
          );
        }else{
          return Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(400),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            height: ScreenUtil().setHeight(80),
            width:size.width -  ScreenUtil().setWidth(200),
            child: CupertinoButton(child: Text('登记',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){ 
             
            }),
          );
        }
      }
    );
  }

}