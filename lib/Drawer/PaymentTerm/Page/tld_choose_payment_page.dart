import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_choose_payment_cell.dart';
import 'tld_bank_card_info_page.dart';
import 'tld_wecha_alipay_info_page.dart';

class TLDChoosePaymentPage extends StatefulWidget {
  TLDChoosePaymentPage({Key key}) : super(key: key);

  @override
  _TLDChoosePaymentPageState createState() => _TLDChoosePaymentPageState();
}

class _TLDChoosePaymentPageState extends State<TLDChoosePaymentPage> {

    List titles = [
    '银行卡',
    '微信',
    '支付宝',
    ];
    
    List icons = [
      0xe679,
      0xe61d,
      0xe630
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'choose_payment_page',
        transitionBetweenRoutes: false,
        middle: Text('收款方式'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (BuildContext context, int index){
        return TLDChoosePaymentCell(title : titles[index], iconInt: icons[index],
          didClickCallBack: (){
            if (index == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDBankCardInfoPage()));
            }else{
              TLDWechatAliPayInfoPageType type;
              if (index == 1) {
                type = TLDWechatAliPayInfoPageType.weChat;
              }else{
                type = TLDWechatAliPayInfoPageType.aliPay;
              }
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDWechatAliPayInfoPage(type: type,)));
            }
          },
        );
      }
    );
  }

  void changePurseName(BuildContext context){
   
  }

}