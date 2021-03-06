import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_payment_diy_info_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_payment_manager_add_payment_cell.dart';
import '../Model/tld_payment_manager_model_manager.dart';
import '../View/tld_payment_manager_cell.dart';
import 'tld_bank_card_info_page.dart';
import 'tld_wecha_alipay_info_page.dart';


enum TLDPaymentType{
  wechat,
  alipay,
  bank,
  diy
}

class TLDPaymentManagerPage extends StatefulWidget {
  TLDPaymentManagerPage({Key key,this.type,this.walletAddress,this.isChoosePayment,this.didChoosePaymentCallBack}) : super(key: key);

  final TLDPaymentType type;

  final bool isChoosePayment;

  final String walletAddress;

  final Function(TLDPaymentModel) didChoosePaymentCallBack;

  @override
  _TLDPaymentManagerPageState createState() => _TLDPaymentManagerPageState();
}

class _TLDPaymentManagerPageState extends State<TLDPaymentManagerPage> {
  RefreshController _refreshController;

  List _dataSource;

  TLDPaymentManagerModelManager _manager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh:true);

    _manager = TLDPaymentManagerModelManager();

    _dataSource = [];

    _getPaymentList();
  }



  void _getPaymentList(){
    _manager.getPaymentInfoList(widget.walletAddress, widget.type, (List dataList){
      _dataSource = [];
      _refreshController.refreshCompleted();
      if (mounted){
      setState(() {
        _dataSource.addAll(dataList);
      });
      }
    }, (TLDError error) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(
          msg: error.msg,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }


  void refreshPaymentList(){
    _refreshController.requestRefresh();
    _getPaymentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'payment_manager_page',
        transitionBetweenRoutes: false,
        middle: Text(_getPageTitle()),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getRefreshWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getRefreshWidget(){
    return SmartRefresher(
      controller:_refreshController,
      header: WaterDropHeader(
        complete: Text(I18n.of(navigatorKey.currentContext).refreshComplete)
      ),
      onRefresh:()=> _getPaymentList(),
      child: _getBodyWidget(),
      );
  }

  String _getPageTitle(){
    if(widget.type == TLDPaymentType.wechat){
      return I18n.of(context).manageWechat;
    }else if(widget.type == TLDPaymentType.alipay){
      return I18n.of(context).manageAlipay;
    }else if (widget.type == TLDPaymentType.bank){
      return I18n.of(context).manageAlipay;
    }else {
      return I18n.of(context).manageCustomMethod;
    }
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length + 1,
      itemBuilder: (BuildContext context,int index){
        if(index == _dataSource.length){
          return TLDPaymentManagerAddPaymentCell(type: widget.type,didClickItemCallBack: (){
            if (widget.type == TLDPaymentType.bank){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDBankCardInfoPage(walletAddress: widget.walletAddress,))).then((value) => refreshPaymentList());
            }else if(widget.type == TLDPaymentType.diy){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDPaymentDiyInfoPage(walletAddress: widget.walletAddress,))).then((value) => refreshPaymentList());
            }else{
              TLDWechatAliPayInfoPageType pageType;
              if (widget.type == TLDPaymentType.wechat){
                pageType = TLDWechatAliPayInfoPageType.weChat;
              }else{
                pageType = TLDWechatAliPayInfoPageType.aliPay;
              }
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDWechatAliPayInfoPage(walletAddress : widget.walletAddress,type : pageType))).then((value) => refreshPaymentList());
            }
          },);
        }else{
          TLDPaymentModel paymentModel = _dataSource[index];
          return TLDPaymentManagerCell(paymentModel: paymentModel,didClickItemCallBack: (){
            if (widget.isChoosePayment == true){
              widget.didChoosePaymentCallBack(paymentModel);
              Navigator.of(context)..pop()..pop();
            }else{
              if (paymentModel.type == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDBankCardInfoPage(walletAddress: widget.walletAddress,paymentModel: paymentModel,))).then((value) => refreshPaymentList());
            }else if(paymentModel.type == 4){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDPaymentDiyInfoPage(walletAddress: widget.walletAddress,paymentModel: paymentModel,))).then((value) => refreshPaymentList());
            }else{
              TLDWechatAliPayInfoPageType pageType;
              if (widget.type == TLDPaymentType.wechat){
                pageType = TLDWechatAliPayInfoPageType.weChat;
              }else{
                pageType = TLDWechatAliPayInfoPageType.aliPay;
              }
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDWechatAliPayInfoPage(walletAddress : widget.walletAddress,type : pageType,paymentModel: paymentModel,))).then((value) => refreshPaymentList());
            }
            }
          },);
        }
      } 
      );
  }

}