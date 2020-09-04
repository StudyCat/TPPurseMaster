import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TLDAcceptanceBillBuyActionSheet extends StatefulWidget {
  TLDAcceptanceBillBuyActionSheet({Key key,this.infoListModel,this.didClickChooseWallet,this.didChooseCountCallBack,this.didClickBuyButtonCallBack}) : super(key: key);

  final TLDBillInfoListModel infoListModel;

  final Function(String) didClickChooseWallet;

  final Function didClickBuyButtonCallBack;

  final Function(int) didChooseCountCallBack;


  @override
  _TLDAcceptanceBillBuyActionSheetState createState() =>
      _TLDAcceptanceBillBuyActionSheetState();
}

class _TLDAcceptanceBillBuyActionSheetState
    extends State<TLDAcceptanceBillBuyActionSheet> {
  int _vote = 0;

  TLDWalletInfoModel _infoModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: ScreenUtil().setHeight(600),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(40),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30)),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(I18n.of(context).buyBill,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 51, 51, 51),
                    decoration: TextDecoration.none)),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                child: _getBillInfoView()),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
              child: _getChooseWidgetView(),
            ),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
                child: _getRealAmount()),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
              child: _getChooseWalletRowWidget(),
            ),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(28)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setHeight(80),
                  child: CupertinoButton(
                    child: Text(
                      I18n.of(context).submitOrder,
                      style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                    ),
                    onPressed: (){
                      if (_vote == 0){
                        Fluttertoast.showToast(msg: '请先选择份数');
                        return;
                      }
                      if (_infoModel == null){
                        Fluttertoast.showToast(msg: '请先选择钱包');
                        return;
                      }
                      widget.didClickBuyButtonCallBack();
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(0),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _getBillInfoView() {
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
                text: TextSpan(children: <InlineSpan>[
              WidgetSpan(
                  child: Icon(
                IconData(0xe670, fontFamily: 'appIconFonts'),
                size: ScreenUtil().setWidth(40),
                color: Theme.of(context).hintColor,
              )),
              TextSpan(
                  text: '  ${widget.infoListModel.billLevel}' + I18n.of(context).levelBill,
                  style: TextStyle(
                      color: Color.fromARGB(255, 102, 102, 102),
                      fontSize: ScreenUtil().setSp(28)))
            ])),
            Text(
              I18n.of(context).univalence  +'：${widget.infoListModel.billPrice}TLD',
              style: TextStyle(
                  color: Color.fromARGB(255, 153, 153, 153),
                  fontSize: ScreenUtil().setSp(28),
                  decoration: TextDecoration.none),
            )
          ]),
    );
  }

  Widget _getChooseWidgetView() {
    return Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _getChoiceList(),
        ));
  }

  List<Widget> _getChoiceList(){
    int count = widget.infoListModel.totalBuyCount - widget.infoListModel.alreadyBuyCount;
    int realCount = count;
    if (count > 4){
      realCount = 4;
    }

    List<Widget> result = [];
    for(int i = 1 ; i < realCount + 1; i++){
      result.add(_getSingleChoiceWidget(i));
    }
    return result;
  }

  Widget _getSingleChoiceWidget(int type) {
    String text;
    if (type == 1) {
      text = '1' + I18n.of(context).part;
    } else if (type == 2) {
      text = '2'+ I18n.of(context).part;
    } else if (type == 3) {
      text = '3' + I18n.of(context).part;
    } else {
      text = '4' + I18n.of(context).part;
    }
    return Row(children: <Widget>[
      Radio(
        value: type,
        groupValue: _vote,
        onChanged: (value) {
          setState(() {
            _vote = value;
          });
          widget.didChooseCountCallBack(value);
        },
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(0)),
          child: Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 51, 51, 51),
                fontSize: ScreenUtil().setSp(28)),
          ))
    ]);
  }

  Widget _getRealAmount() {
    double realAmount = _vote * double.parse(widget.infoListModel.billPrice);
    return RichText(
        text: TextSpan(
            text: I18n.of(context).actuallyPaid + '：',
            style: TextStyle(
              color: Color.fromARGB(255, 153, 153, 153),
              fontSize: ScreenUtil().setSp(28),
            ),
            children: <InlineSpan>[
          TextSpan(
            text: '${realAmount}TLD',
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: ScreenUtil().setSp(48),
            ),
          )
        ]));
  }

  Widget _getChooseWalletRowWidget(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) =>TLDEchangeChooseWalletPage(
                                      didChooseWalletCallBack:(TLDWalletInfoModel infoModel) {
                                        setState(() {
                                          _infoModel = infoModel;
                                        });
                                        widget.didClickChooseWallet(infoModel.walletAddress);
                                      },
                                    )));
      },
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(150),
          child :Text(_infoModel != null ? _infoModel.wallet.name : I18n.of(context).chooseWalletLabel,
              style: TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: ScreenUtil().setSp(28),
                  decoration: TextDecoration.none),)
        ),
        Icon(Icons.keyboard_arrow_right)
      ],
    ),
    );
  }
}
