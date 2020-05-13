import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import '../View/tld_exchange_normalCell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_exchange_input_cell.dart';
import '../View/tld_exchange_input_slider_cell.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';



class TLDExchangePage extends StatefulWidget {
  TLDExchangePage({Key key}) : super(key: key);

  @override
  _TLDExchangePageState createState() => _TLDExchangePageState();
}

class _TLDExchangePageState extends State<TLDExchangePage> {
  
  List titleList = ['钱包', '钱包余额', '兑换量', '限额设置', '手续费率', '手续费', '实际到账', '收款方式'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'exchange_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TLDMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
        trailing: MessageButton(didClickCallBack: () {}),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return ListView.builder(
      itemCount: titleList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
          return TLDExchangeNormalCell(type: TLDExchangeNormalCellType.normalArrow,title: titleList[index],content: 'dqwdqdqd',contentStyle: TextStyle(fontSize : 12),top: 15,);
        }else if (index == 2){
          return TLDExchangeInputSliderCell(title : titleList[index]);
        }else if (index == 3){
          return TLDExchangeInputCell(title: titleList[index],);
        }else if (index == titleList.length){
          return Container(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40),left: 15,right: 15),
            height : ScreenUtil().setHeight(135),
            child: CupertinoButton(color: Color.fromARGB(255, 51, 114, 245),child: Text('兑换',style : TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(28)),), onPressed: (){}),
          );
        }else{
          return TLDExchangeNormalCell(type: TLDExchangeNormalCellType.normal,title: titleList[index],content: 'dqwdqdqd',contentStyle: TextStyle(fontSize : 12),top: 1,);
        }
      },
    );
  }
}
