import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../CommonWidget/tld_clip_title_input_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TLDBankCardInfoPage extends StatefulWidget {
  TLDBankCardInfoPage({Key key}) : super(key: key);

  @override
  _TLDBankCardInfoPageState createState() => _TLDBankCardInfoPageState();
}

class _TLDBankCardInfoPageState extends State<TLDBankCardInfoPage> {
  List titles = [
    '真实姓名',
    '银行卡号',
    '开户行'
  ];

  List placeholders = [
    '请输入您的真实姓名',
    '请输入您的银行卡号',
    '请输入开户行',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'bank_card_info_page',
        transitionBetweenRoutes: false,
        middle: Text('银行卡账号信息'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: titles.length + 1,
      itemBuilder: (BuildContext context, int index){
        if (index < titles.length) {
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TLDClipTitleInputCell(title : titles[index],placeholder: placeholders[index],textFieldEditingCallBack: (String string){
          
        },),
        );
        }else{
          return Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(400),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            height: ScreenUtil().setHeight(80),
            width:size.width -  ScreenUtil().setWidth(200),
            child: CupertinoButton(child: Text('确定',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){ 
              
            }),
          );
        }
      }
    );
  }
}