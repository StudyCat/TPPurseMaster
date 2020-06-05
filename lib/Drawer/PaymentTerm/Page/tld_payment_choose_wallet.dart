import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/credentials.dart';
import 'tld_choose_payment_page.dart';


class TLDPaymentChooseWalletPage extends StatefulWidget {
  TLDPaymentChooseWalletPage({Key key}) : super(key: key);

  @override
  _TLDPaymentChooseWalletPageState createState() => _TLDPaymentChooseWalletPageState();
}

class _TLDPaymentChooseWalletPageState extends State<TLDPaymentChooseWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'choose_payment_wallet_page',
        transitionBetweenRoutes: false,
        middle: Text('选择钱包'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }




  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: TLDDataManager.instance.purseList.length,
      itemBuilder: (BuildContext context, int index) {
        TLDWallet wallet = TLDDataManager.instance.purseList[index];
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TLDChoosePaymentPage(walletAddress: wallet.address,)));
          },
          child: Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(2)),
            child: TLDClipCommonCell(title: wallet.name,titleStyle: TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(28)),type: TLDClipCommonCellType.normalArrow,content: '',),
          )
        );
     });
  }


}