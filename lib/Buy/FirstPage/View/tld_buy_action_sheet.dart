import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../View/tld_buy_action_sheet_input_view.dart';
import '../../../Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';

class TLDBuyActionSheet extends StatefulWidget {
  TLDBuyActionSheet({Key key,this.model,this.didClickBuyBtnCallBack}) : super(key: key);

  final TLDBuyListInfoModel model;

  final Function(TLDBuyPramaterModel) didClickBuyBtnCallBack;

  @override
  _TLDBuyActionSheetState createState() => _TLDBuyActionSheetState();
}

class _TLDBuyActionSheetState extends State<TLDBuyActionSheet> {
  
  TLDBuyPramaterModel _pramaterModel;

  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pramaterModel = TLDBuyPramaterModel();
    _pramaterModel.buyCount = '0';
    _pramaterModel.sellNo = widget.model.sellNo;

    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child : Padding(
      padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
      height: ScreenUtil().setHeight(600),
      width: size.width,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('购买',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 51, 51, 51),
                  decoration: TextDecoration.none)),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: TLDBuyActionSheetInputView(focusNode: _focusNode,maxAmount: widget.model.maxAmount, max: widget.model.max,currentAmount: widget.model.currentCount,inputStringCallBack: (String text){
              setState(() {
                _pramaterModel.buyCount = text;
              });
            },),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView('最低购买额度', widget.model.max + 'TLD'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView('最高购买额度', widget.model.maxAmount + 'TLD'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: getNormalView('实际付款', _pramaterModel.buyCount + 'CNY'),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
            child: GestureDetector(
              onTap:(){
                _focusNode.unfocus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => TLDEchangeChooseWalletPage(didChooseWalletCallBack: (TLDWalletInfoModel infoModel){
                  setState(() {
                    _pramaterModel.buyerAddress = infoModel.walletAddress;
                  });
                },)));
              },
              child : getArrowView('接收地址', _pramaterModel.buyerAddress == null ? '请选择接收钱包' : _pramaterModel.buyerAddress)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('下单',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
              if (double.parse(_pramaterModel.buyCount) == 0.0){
                Fluttertoast.showToast(msg: '请填写购买数量',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              if (_pramaterModel.buyerAddress == null){
                Fluttertoast.showToast(msg: '请选择接收钱包',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
                return;
              }
              // if (double.parse(_pramaterModel.buyCount) < double.parse(widget.model.max) && double.parse(widget.model.max) < double.parse(widget.model.totalCount)){
              //   Fluttertoast.showToast(msg: '输入的购买数量低于最低购买额度',toastLength: Toast.LENGTH_SHORT,
              //           timeInSecForIosWeb: 1);
              //   return;
              // }
              widget.didClickBuyBtnCallBack(_pramaterModel);
              Navigator.of(context).pop();
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )],
      ),
    ),
    )
    );
  }

  Widget getNormalView(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Text(
          content,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
      ],
    );
  }

  Widget getArrowView(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Row(children: <Widget>[
          Container(width : ScreenUtil().setWidth(400),child : Text(
            content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 153, 153, 153)),
          )),
          Icon(Icons.keyboard_arrow_right)
        ])
      ],
    );
  }
}
