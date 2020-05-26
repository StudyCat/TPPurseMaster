import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import '../View/tld_exchange_normalCell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_exchange_input_cell.dart';
import '../View/tld_exchange_input_slider_cell.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Message/Page/tld_message_page.dart';
import 'tld_exchange_choose_wallet.dart';



class TLDExchangePage extends StatefulWidget {
  TLDExchangePage({Key key}) : super(key: key);

  @override
  _TLDExchangePageState createState() => _TLDExchangePageState();
}

class _TLDExchangePageState extends State<TLDExchangePage> {
  
  List titleList = ['钱包', '钱包余额', '兑换量', '限额设置', '手续费率', '手续费', '实际到账', '收款方式'];

  TLDWalletInfoModel _infoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor:  Color.fromARGB(255, 51, 51, 51),
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'exchange_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        trailing: MessageButton(
          didClickCallBack: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => TLDMessagePage())),
        ),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return ListView.builder(
      itemCount: titleList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
          return TLDExchangeNormalCell(type: TLDExchangeNormalCellType.normalArrow,title: titleList[index],content: _infoModel == null ?'选择钱包':_infoModel.wallet.name,contentStyle: TextStyle(fontSize : 12,color: Color.fromARGB(255, 153, 153, 153)),top: 15,didClickCallBack: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDEchangeChooseWalletPage(didChooseWalletCallBack: (TLDWalletInfoModel infoModel){
              setState(() {
                _infoModel = infoModel;
              });
            },)));
          },);
        }else if (index == 2){
          return TLDExchangeInputSliderCell(title : titleList[index],infoModel: _infoModel,);
        }else if (index == 3){
          return TLDExchangeInputCell(title: titleList[index],);
        }else if (index == titleList.length){
          return Container(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40),left: 15,right: 15),
            height : ScreenUtil().setHeight(135),
            child: CupertinoButton(color: Theme.of(context).primaryColor,child: Text('兑换',style : TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(28)),), onPressed: (){}),
          );
        }else{
          String content = '';
          if(index == 1){
            content = _infoModel == null ? '0.0' : _infoModel.value;
          }
          return TLDExchangeNormalCell(type: TLDExchangeNormalCellType.normal,title: titleList[index],content: content,contentStyle: TextStyle(fontSize : 12,color: Color.fromARGB(255, 153, 153, 153)),top: 1,);
        }
      },
    );
  }
}
