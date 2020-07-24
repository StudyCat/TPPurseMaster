import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_choose_payment_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_input_slider_cell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_normalCell.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_payment_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_with_draw_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_detail_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_bottom_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_choose_type_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_slider_input.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
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

  List _platformTitleList = ['钱包余额', '兑换量', '预计到账', '推荐卖家', '手续费率', '手续费', '收款方式'];
  
  List _referrerTitleList = ['钱包余额', '兑换量', '预计到账', '推荐卖家', '收款方式'];

  TLDAcceptanceWithdrawPageType _type = TLDAcceptanceWithdrawPageType.referrer;

  FocusNode _withdrawInputNode;

  TLDAceeptanceWithdrawUsefulInfoModel _usefulInfoModel;

  TLDWithdrawPramaterModel _pramaterModel;
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
          String content;
          if (index == 0){
            top = ScreenUtil().setHeight(2);
            content = _usefulInfoModel != null ? _usefulInfoModel.value : '0.0';
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
        } else if (index == 1) {
          return TLDAcceptanceWithdrawSliderInputCell(
            title: _titleList[index],
            maxValue: _usefulInfoModel != null ? _usefulInfoModel.value : null,
            focusNode: _withdrawInputNode,
            inputCallBack: (String text) {
              setState(() {
                _pramaterModel.cashCount = text;
              });
            },
          );
        }else if (index == 3){
          return TLDAcceptanceWithdrawChooseTypeCell(
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
          if (index == 4 || index == 5){
            String content = '';
            if (index == 4){
              double rate = _usefulInfoModel != null ? double.parse(_usefulInfoModel.acptPlatformCachRate) * 100 : 0;
              content = '${rate}%';
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
          }else if(index == 6){
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
          if (index == 4){
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
    );
  }

}