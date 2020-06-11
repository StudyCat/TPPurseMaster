import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_choose_payment_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Model/tld_exchange_model_manager.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_payment_cell.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../View/tld_exchange_normalCell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_exchange_input_cell.dart';
import '../View/tld_exchange_input_slider_cell.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Message/Page/tld_message_page.dart';
import 'tld_exchange_choose_wallet.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDExchangePage extends StatefulWidget {
  TLDExchangePage({Key key,this.infoModel}) : super(key: key);

  final TLDWalletInfoModel infoModel;


  @override
  _TLDExchangePageState createState() => _TLDExchangePageState();
}

class _TLDExchangePageState extends State<TLDExchangePage> {
  List titleList = ['钱包', '钱包余额', '兑换量', '最低购买额度设置', '手续费率', '手续费', '实际到账', '收款方式'];

  TLDSaleFormModel _formModel;

  TLDExchangeModelManager _manager;

  bool _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formModel = TLDSaleFormModel();
    _formModel.maxBuyAmount = '0';
    _formModel.saleAmount = '0';
    _formModel.payMethodName = '微信支付';

    if (widget.infoModel != null){
      _formModel.infoModel = widget.infoModel;
    }

    _isLoading = false;
    _manager = TLDExchangeModelManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBody(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'exchange_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        trailing: MessageButton(
          didClickCallBack: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => TLDMessagePage())),
        ),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return ListView.builder(
      itemCount: titleList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normalArrow,
            title: titleList[index],
            content: _formModel.infoModel == null
                ? '选择钱包'
                : _formModel.infoModel.wallet.name,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: 15,
            didClickCallBack: () {
              if(widget.infoModel == null){
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TLDEchangeChooseWalletPage(
                            didChooseWalletCallBack:
                                (TLDWalletInfoModel infoModel) {
                              setState(() {
                                _formModel.infoModel = infoModel;
                              });
                            },
                          )));
              }
            },
          );
        } else if (index == 2) {
          return TLDExchangeInputSliderCell(
            title: titleList[index],
            infoModel: _formModel.infoModel,
            inputCallBack: (String text) {
              setState(() {
                _formModel.saleAmount = text;
              });
            },
          );
        } else if (index == 3) {
          return TLDExchangeInputCell(
              title: titleList[index],
              infoModel: _formModel.infoModel,
              inputCallBack: (String text) {
                _formModel.maxBuyAmount = text;
              });
        }else if (index == titleList.length -1){
          return TLDExchangePaymentCell(paymentModel: _formModel.paymentModel,didClickItemCallBack: (){
            if (_formModel.infoModel != null){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDChoosePaymentPage(walletAddress:_formModel.infoModel.walletAddress,isChoosePayment: true,didChoosePaymentCallBack: (TLDPaymentModel paymentModel){
                setState(() {
                  _formModel.paymentModel = paymentModel;
                });
              },)));
            }
          },);
        }else if (index == titleList.length) {
          return Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(40), left: 15, right: 15),
            height: ScreenUtil().setHeight(135),
            child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  '兑换',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                ),
                onPressed: () => submitSaleForm()),
          );
        } else {
          String content = '';
          if (index == 1) {
            content = _formModel.infoModel == null
                ? '0.0'
                : _formModel.infoModel.value;
          } else if (index == 4) {
            content =  _formModel.infoModel == null ?  '0%' : (double.parse(_formModel.infoModel.rate) * 100).toString() + '%';
          } else if (index == 5) {
            if (_formModel.infoModel != null){
              double amount = double.parse(_formModel.saleAmount) * double.parse(_formModel.infoModel.rate);
              content = amount.toString() + 'TLD';
            }else{
              content = '0TLD';
            }
          } else if (index == 6) {
            if (_formModel.infoModel != null){
              double amount = double.parse(_formModel.saleAmount) * double.parse(_formModel.infoModel.rate);
              double trueAmount = double.parse(_formModel.saleAmount) - amount;
              content = '¥' + trueAmount.toString();
            }else{
              content = '¥0';
            }
          }
          return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normal,
            title: titleList[index],
            content: content,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: 1,
          );
        }
      },
    );
  }

  void submitSaleForm() {
    if(double.parse(_formModel.saleAmount) == 0.0){
        Fluttertoast.showToast(
          msg: '请输入兑换量', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if(double.parse(_formModel.maxBuyAmount) == 0.0){
        Fluttertoast.showToast(
          msg: '请输入最低购买额度', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if(_formModel.infoModel == null){
        Fluttertoast.showToast(
          msg: '请选择钱包', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    if(_formModel.paymentModel == null){
        Fluttertoast.showToast(
          msg: '请选择支付方式', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
        return;
    }
    setState(() {
      _isLoading = true;
    });
    _manager.submitSaleForm(_formModel, () {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: '兑换成功', toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TLDError error) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }
}
