import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import '../View/tld_exchange_normalCell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_exchange_input_cell.dart';
import '../View/tld_exchange_input_slider_cell.dart';



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
                Scaffold.of(context).openDrawer();
              });
        }),
        automaticallyImplyLeading: false,
        trailing: MessageButton(didClickCallBack: () {}),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return ListView.builder(
      itemCount: titleList.length,
      itemBuilder: (BuildContext context, int index) {
        String title = titleList[index];
        if (index == 0){
          return TLDExchangeNormalCell(type: TLDExchangeNormalCellType.normalArrow,title: title,content: 'dqwdqdqd',contentStyle: TextStyle(fontSize : 12),top: 15,);
        }else if (index == 2){
          return TLDExchangeInputSliderCell(title : title);
        }else if (index == 3){
          return TLDExchangeInputCell(title: title,);
        }else{
          return TLDExchangeNormalCell(type: TLDExchangeNormalCellType.normal,title: title,content: 'dqwdqdqd',contentStyle: TextStyle(fontSize : 12),top: 1,);
        }
      },
    );
  }
}
