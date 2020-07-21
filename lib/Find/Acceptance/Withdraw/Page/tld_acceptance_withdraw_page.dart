import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_choose_payment_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_input_slider_cell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_normalCell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_payment_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_bottom_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_choose_type_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_slider_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

enum TLDAcceptanceWithdrawPageType{
   referrer,
   platform
}

class TLDAcceptanceWithdrawPage extends StatefulWidget {
  TLDAcceptanceWithdrawPage({Key key,this.walletAddress}) : super(key: key);

  final String walletAddress;

  @override
  _TLDAcceptanceWithdrawPageState createState() => _TLDAcceptanceWithdrawPageState();
}

class _TLDAcceptanceWithdrawPageState extends State<TLDAcceptanceWithdrawPage> {

  bool _isLoading = false;

  List _platformTitleList = ['钱包余额', '兑换量', '预计到账', '推荐卖家', '手续费率', '手续费', '收款方式'];
  
  List _referrerTitleList = ['钱包余额', '兑换量', '预计到账', '推荐卖家', '收款方式'];

  TLDAcceptanceWithdrawPageType _type = TLDAcceptanceWithdrawPageType.referrer;

  FocusNode _withdrawInputNode;

  TLDPaymentModel _paymentModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _withdrawInputNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBody()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'exchange_page',
        transitionBetweenRoutes: false,
        middle: Text('承兑收益提现'),
      ),
    );
  }

  Widget _getBody(){
    List _titleList = [];
    if (_type == TLDAcceptanceWithdrawPageType.referrer){
      _titleList.addAll(_referrerTitleList);
    }else{
      _titleList.addAll(_platformTitleList);
    }
     return ListView.builder(
      itemCount: _titleList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0 || index == 2) {
          double top;
          if (index == 0){
            top = ScreenUtil().setHeight(2);
          }else{
            top = ScreenUtil().setHeight(10);
          }
          return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normal,
            title: _titleList[index],
            content: '',
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: top,
          );
        } else if (index == 1) {
          return TLDAcceptanceWithdrawSliderInputCell(
            title: _titleList[index],
            maxValue: '1000',
            focusNode: _withdrawInputNode,
            inputCallBack: (String text) {

            },
          );
        }else if (index == 3){
          return TLDAcceptanceWithdrawChooseTypeCell(
            didVoteCallBack: (int index){
              if (index == 1){
                setState(() {
                  _type = TLDAcceptanceWithdrawPageType.referrer;
                });
              }else{
                setState(() {
                  _type = TLDAcceptanceWithdrawPageType.platform;
                });
              }
            },
            title: _titleList[index],
          );
        }
        if (_type == TLDAcceptanceWithdrawPageType.platform){
          if (index == 4 || index == 5){
            return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normal,
            title: _titleList[index],
            content: '',
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: ScreenUtil().setHeight(2),
          );
          }else if(index == 6){
            return TLDExchangePaymentCell(paymentModel:_paymentModel,didClickItemCallBack: (){
            _withdrawInputNode.unfocus();
            // if (_formModel.infoModel != null){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDChoosePaymentPage(walletAddress:widget.walletAddress,isChoosePayment: true,didChoosePaymentCallBack: (TLDPaymentModel paymentModel){
                setState(() {
                  _paymentModel = paymentModel;
                });
              },)));
            },);
          }
        }else{
          if (index == 4){
            return TLDExchangePaymentCell(paymentModel:_paymentModel,didClickItemCallBack: (){
            _withdrawInputNode.unfocus();
            // if (_formModel.infoModel != null){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDChoosePaymentPage(walletAddress:widget.walletAddress,isChoosePayment: true,didChoosePaymentCallBack: (TLDPaymentModel paymentModel){
                setState(() {
                  _paymentModel = paymentModel;
                });
              },)));
            },);
          }
        }
        return TLDAcceptanceWithDrawBottomCell();
        }
    );
  }

}