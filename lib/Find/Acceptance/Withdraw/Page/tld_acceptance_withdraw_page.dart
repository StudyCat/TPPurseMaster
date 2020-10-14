import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_choose_payment_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_input_slider_cell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_normalCell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_payment_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_with_draw_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_detail_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_bottom_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_choose_type_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_slider_input.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  TLDAcceptanceWithdrawModelManager _modelManager;

  bool _isLoading = false;

  List _platformTitleList = [I18n.of(navigatorKey.currentContext).wallet,I18n.of(navigatorKey.currentContext).walletBalance, I18n.of(navigatorKey.currentContext).exchangeAmount, I18n.of(navigatorKey.currentContext).expectedToAccount, I18n.of(navigatorKey.currentContext).recommendSeller, I18n.of(navigatorKey.currentContext).serviceChargeRateLabel, I18n.of(navigatorKey.currentContext).serviceChargeLabel, I18n.of(navigatorKey.currentContext).collectionMethod];
  
  List _referrerTitleList = [I18n.of(navigatorKey.currentContext).wallet,I18n.of(navigatorKey.currentContext).walletBalance, I18n.of(navigatorKey.currentContext).exchangeAmount, I18n.of(navigatorKey.currentContext).expectedToAccount, I18n.of(navigatorKey.currentContext).recommendSeller,I18n.of(navigatorKey.currentContext).referrerContactWay, I18n.of(navigatorKey.currentContext).collectionMethod];

  TLDAcceptanceWithdrawPageType _type = TLDAcceptanceWithdrawPageType.referrer;

  FocusNode _withdrawInputNode;

  TLDWithdrawPramaterModel _pramaterModel;

  TLDWalletInfoModel _walletInfoModel;

  TLDAceeptanceWithdrawUsefulInfoModel _usefulInfoModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pramaterModel = TLDWithdrawPramaterModel();
    _pramaterModel.cashType = 1;
    _pramaterModel.cashCount = '0';

    _withdrawInputNode = FocusNode();

    _modelManager = TLDAcceptanceWithdrawModelManager();
    _getUsefulInfo();
  }

  void _getUsefulInfo(){
    if(mounted){
      setState(() {
      _isLoading = true;
    });
    }
    _modelManager.getUsefulInfo((TLDAceeptanceWithdrawUsefulInfoModel usefulInfoModel){
      if (mounted){
        setState(() {
          _isLoading = false;
          _usefulInfoModel = usefulInfoModel;
        });
      }
    }, (TLDError error){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _withdraw(){
    if (mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.withdraw(_pramaterModel, (String cashNo){
    if (mounted){
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => TLDAcceptanceDetailWithdrawPage(cashNo: cashNo,)));
    }
    }, (TLDError error){
      if (mounted){
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: error.msg);
    }
    });
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
        trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TLDWebPage(type: TLDWebPageType.cashDescUrl,title: '提现说明',)));
        }),
        heroTag: 'exchange_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包提现'),
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
     return _usefulInfoModel != null ? ListView.builder(
      itemCount: _titleList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
           return GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => TLDEchangeChooseWalletPage(
                 didChooseWalletCallBack: (TLDWalletInfoModel infoModel){
                   setState(() {
                     _walletInfoModel = infoModel;
                     _pramaterModel.walletAddress = _walletInfoModel.walletAddress;
                   });
                 },
               ),));
             },
             child: TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normalArrow,
            title: _titleList[index],
            content: _walletInfoModel != null ? _walletInfoModel.wallet.name : I18n.of(context).chooseWalletLabel,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: ScreenUtil().setHeight(2),
          ),
           );
        } else if (index == 1 || index == 3) {
          double top;
          String content;
          if (index == 1){
            top = ScreenUtil().setHeight(2);
            content = _walletInfoModel != null ? _walletInfoModel.value : '0.0';
          }else{
            top = ScreenUtil().setHeight(10);
            if (_pramaterModel.cashType == 1){
              content = _pramaterModel.cashCount;
            }else{
              double amount = _usefulInfoModel != null ? (double.parse(_pramaterModel.cashCount) * double.parse(_usefulInfoModel.acptPlatformCachRate)) : 0.0;
              double realAmount = double.parse(_pramaterModel.cashCount) - amount;
              content = (NumUtil.getNumByValueDouble(realAmount, 3)).toStringAsFixed(3);
            }
          }
          return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normal,
            title: _titleList[index],
            content: content,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: top,
          );
        } else if (index == 2) {
          return TLDAcceptanceWithdrawSliderInputCell(
            title: _titleList[index],
            maxValue: _walletInfoModel != null ? _walletInfoModel.value : null,
            focusNode: _withdrawInputNode,
            inputCallBack: (String text) {
              setState(() {
                _pramaterModel.cashCount = text;
              });
            },
          );
        }else if (index == 4){
          return TLDAcceptanceWithdrawChooseTypeCell(
            usefulInfoModel: _usefulInfoModel,
            didVoteCallBack: (int index){
              if (index == 1){
                setState(() {
                  _type = TLDAcceptanceWithdrawPageType.referrer;
                  _pramaterModel.cashType = 1;
                });
              }else{
                setState(() {
                  _type = TLDAcceptanceWithdrawPageType.platform;
                  _pramaterModel.cashType = 2;
                });
              }
            },
            title: _titleList[index],
          );
        }
        if (_type == TLDAcceptanceWithdrawPageType.platform){
          if (index == 5 || index == 6){
            String content = '';
            if (index == 5){
              double rate = _usefulInfoModel != null ? double.parse(_usefulInfoModel.acptPlatformCachRate) * 100 : 0;
              String rateStr = (NumUtil.getNumByValueDouble(rate, 4)).toStringAsFixed(4);
              content = '${rateStr}%';
            }else{
              double amount = _usefulInfoModel != null ? (double.parse(_pramaterModel.cashCount) * double.parse(_usefulInfoModel.acptPlatformCachRate)) : 0.0;
              content = (NumUtil.getNumByValueDouble(amount, 3)).toStringAsFixed(3);
            }
            return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normal,
            title: _titleList[index],
            content: content,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: ScreenUtil().setHeight(2),
          );
          }else if(index == 7){
            return TLDExchangePaymentCell(paymentModel:_pramaterModel.paymentModel,didClickItemCallBack: (){
            _withdrawInputNode.unfocus();
            // if (_formModel.infoModel != null){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDChoosePaymentPage(walletAddress:widget.walletAddress,isChoosePayment: true,didChoosePaymentCallBack: (TLDPaymentModel paymentModel){
                setState(() {
                  _pramaterModel.paymentModel = paymentModel;
                });
              },)));
            },);
          }
        }else{
          if (index == 6){
            return TLDExchangePaymentCell(paymentModel:_pramaterModel.paymentModel,didClickItemCallBack: (){
            _withdrawInputNode.unfocus();
            // if (_formModel.infoModel != null){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDChoosePaymentPage(walletAddress:widget.walletAddress,isChoosePayment: true,didChoosePaymentCallBack: (TLDPaymentModel paymentModel){
                setState(() {
                  _pramaterModel.paymentModel = paymentModel;
                });
              },)));
            },);
          }else if(index == 5){
          return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normal,
            title: _titleList[index],
            content: _usefulInfoModel != null ? _usefulInfoModel.inviteTel : '',
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: ScreenUtil().setHeight(2),
          );
          }
        }
        return TLDAcceptanceWithDrawBottomCell(
          didClickButtonCallBack: (){
            if (double.parse(_pramaterModel.cashCount) == 0.0) {
              Fluttertoast.showToast(msg: '请输入兑换量');
              return;
            }
            if (_pramaterModel.paymentModel == null) {
              Fluttertoast.showToast(msg: '请选择支付方式');
              return;
            }
            _withdraw();
          },
        );
        }
    ) : Container();
  }

}