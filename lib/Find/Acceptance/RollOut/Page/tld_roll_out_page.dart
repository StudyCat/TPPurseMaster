

import 'package:common_utils/common_utils.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/View/tld_exchange_normalCell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/RollOut/Model/tld_roll_out_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/RollOut/View/tld_roll_out_bottom_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/RollOut/View/tld_roll_out_slider_inpute_cell.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';


class TLDRollOutPage extends StatefulWidget {
  TLDRollOutPage({Key key}) : super(key: key);

  @override
  _TLDRollOutPageState createState() => _TLDRollOutPageState();
}

class _TLDRollOutPageState extends State<TLDRollOutPage> {

  TLDRollOutModelManager _modelManager;

  TLDRollOutAwardModel _awardModel;

  List _titlesList = [];

  bool _isLoading = false;

  TLDRollOutPramaterModel _pramaterModel;

  FocusNode _amountNode = FocusNode();

  @override
  void initState() { 
    super.initState();

    _pramaterModel = TLDRollOutPramaterModel();
    
    _modelManager = TLDRollOutModelManager();
    _getAwardInfo();
  }

  void _getAwardInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getAwardInfo((TLDRollOutAwardModel awardModel){
      if (mounted){
        setState(() {
          if (awardModel.isNeedAward == false){
          _titlesList = [I18n.of(context).walletBalance,I18n.of(context).rollOutLimitAmount,I18n.of(context).exchangeAmount,I18n.of(context).totalToAccount,I18n.of(context).receiveAddressLabel];
        }else{
          _titlesList = [I18n.of(context).walletBalance,I18n.of(context).rollOutLimitAmount,I18n.of(context).exchangeAmount,I18n.of(context).totalToAccount,I18n.of(context).rollOutAward,I18n.of(context).receiveAddressLabel];
        }
        _isLoading = false;
        _awardModel = awardModel;
        _pramaterModel.amount = awardModel.min;
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

  void _rollOut(){
    if (_pramaterModel.infoModel == null){
      Fluttertoast.showToast(msg: '请选择钱包');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _modelManager.rollOut(_pramaterModel, (){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '转出成功');
      Navigator.of(context).pop();
    }, (TLDError error){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
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
        // trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
        //   Navigator.push(context, MaterialPageRoute(builder : (context) => TLDWebPage(type: TLDWebPageType.cashDescUrl,title: '提现说明',)));
        // }),
        heroTag: 'exchange_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).rollOut),
      ),
    );
  }

   Widget _getBody(){
     return ListView.builder(
      itemCount: _titlesList.length > 0 ? _titlesList.length + 1 : 0,
      itemBuilder: (BuildContext context, int index) {
        if (index == 2) {
          return TLDRollOutSliderInputeCell(
            title: _titlesList[index],
            minValue: _awardModel.min,
            maxValue: _awardModel.max,
            focusNode: _amountNode,
            inputCallBack: (String text) {
              setState(() {
                _pramaterModel.amount = text;
              });
            },
          );
        } else if (index == _titlesList.length - 1){
          return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normalArrow,
            title: _titlesList[index],
            content: _pramaterModel.infoModel == null
                ? I18n.of(context).chooseWallet
                : _pramaterModel.infoModel.wallet.name,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: 1,
            didClickCallBack: () {
              _amountNode.unfocus();
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TLDEchangeChooseWalletPage(
                            didChooseWalletCallBack:
                                (TLDWalletInfoModel infoModel) {
                              setState(() {
                                _pramaterModel.infoModel = infoModel;
                              });
                            },
                )));
            },
          );
        }else if (index == _titlesList.length) {
          return TLDRollOutBottomCell(awardModel: _awardModel,didClickRollOutButton: () => _rollOut(),);
        }else {
          String content = '';
          if (index == 0){
            content = '${_awardModel.totalTld}TLD';
          }else if(index == 1){
            content = '${_awardModel.min}TLD ~ ${_awardModel.max}TLD';
          }else if (index == 3){
            double award = double.parse(_pramaterModel.amount) * double.parse(_awardModel.awardRate);
            double amount = award + double.parse(_pramaterModel.amount);
            String amountString = (NumUtil.getNumByValueDouble(amount, 3)).toStringAsFixed(3);
            content = amountString + 'TLD';
          }else{
            double award = double.parse(_pramaterModel.amount) * double.parse(_awardModel.awardRate);
             String amountString = (NumUtil.getNumByValueDouble(award, 3)).toStringAsFixed(3);
            content = amountString + 'TLD';
          }
          return TLDExchangeNormalCell(
            type: TLDExchangeNormalCellType.normal,
            title: _titlesList[index],
            content: content,
            contentStyle: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 153, 153, 153)),
            top: 1,
          );
        }
      },
    );
  }


}