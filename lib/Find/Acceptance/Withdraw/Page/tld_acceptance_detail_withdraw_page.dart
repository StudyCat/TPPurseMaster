import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_detail_withdraw_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_detail_withdraw_bottom_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_detail_withdraw_header_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_bottom_cell.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_alipay_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_order_paymethod_cell.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_wechat_qrcode_show_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDAcceptanceDetailWithdrawPage extends StatefulWidget {
  TLDAcceptanceDetailWithdrawPage({Key key,this.cashNo}) : super(key: key);
 
  final String cashNo;

  @override
  _TLDAcceptanceDetailWithdrawPageState createState() => _TLDAcceptanceDetailWithdrawPageState();
}

class _TLDAcceptanceDetailWithdrawPageState extends State<TLDAcceptanceDetailWithdrawPage> {
  List referrerTitles = ['订单号', '数量', '应付款', '收款方式', '接收地址','买家'];
  List platformTitles = ['订单号', '数量', '应付款', '收款方式', '接收地址','买家','手续费率','手续费'];
  bool isOpen = false;
  StreamController _controller;
  bool _isLoading = false;
  // StreamSubscription _systemSubscreption;

  TLDAcceptanceDetailWithdrawModelManager _modelManager;

  TLDAcceptanceWithdrawOrderListModel _detailModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = StreamController();

    _modelManager = TLDAcceptanceDetailWithdrawModelManager();
    _getDetailInfo();
    // _registerSystemEvent();
  }

  void _getDetailInfo(){
    if (mounted){
      setState(() {
        _isLoading = true;
    });
    }
    _modelManager.getDetailInfo(widget.cashNo, (TLDAcceptanceWithdrawOrderListModel detailModel){
      if (mounted){
      setState(() {
        _isLoading = false;
        _detailModel = detailModel;
    });
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading:_isLoading, child: StreamBuilder(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          // TLDDetailOrderModel model = snapshot.data;
          // if (model == null){
          //   return LoadingOverlay(isLoading: true, child: Container());
          // }else{
            return  NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_getAppBar()];
          },
          body: _getBodyWidget(context)
          );
          // }
        },
      )),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getAppBar() {
    return SliverAppBar(
      centerTitle: true, //标题居中
      expandedHeight: 200.0, //展开高度200
      backgroundColor: Theme.of(context).primaryColor,
      leading: Container(
        height: ScreenUtil().setHeight(34),
        width: ScreenUtil().setHeight(34),
        child: CupertinoButton(
          child: Icon(
            IconData(
              0xe600,
              fontFamily: 'appIconFonts',
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floating: true, //不随着滑动隐藏标题
      pinned: true, //不固定在顶部
      title: Text('订单详情'),
      flexibleSpace: FlexibleSpaceBar(
        background: TLDAcceptanceDetailWithdrawHeaderView(
          detailModel: _detailModel,
        didClickChatBtnCallBack: (){
          // String toUserName = '';
          // if (_detailOrderModel.amIBuyer){
          //   toUserName = _detailOrderModel.sellerUserName;
          // }else{
          //   toUserName = _detailOrderModel.buyerUserName;
          // }
          // Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(toUserName: toUserName,orderNo: _detailOrderModel.orderNo,))).then((value){
          //   _getDetailOrderInfo();
          // });
        },
        timeIsOverRefreshUICallBack: (){
        //   _detailOrderModel = null;
        //   _controller.sink.add(_detailOrderModel);
        //   _getDetailOrderInfo();
        // },didClickAppealBtnCallBack: (){
        //  _jumpToOrderAppeal();
        },
        ),
      ),
    );
  }

  void _jumpToOrderAppeal(){
    //  if (_detailOrderModel.appealId == -1) {
    //         Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDOrderAppealPage(orderModel: _detailOrderModel,))).then((value) => _getDetailOrderInfo());
    //       }else{
    //         Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDJustNoticePage(appealId: _detailOrderModel.appealId,type: TLDJustNoticePageType.appealWatching,))).then((value) => _getDetailOrderInfo());
    //       }
  }

  Widget _getBodyWidget(BuildContext context) {
  //  bool isNeedAppeal = false;
  //   String appealTitle = '';
  //   _getAppealStatusAndAppealTitle((bool isNeed, String title){
  //     isNeedAppeal = isNeed;
  //     appealTitle = title;
  //   });
    if (_detailModel == null){
      return Container();
    }else{
      List titles = _detailModel.cashType == 1 ? referrerTitles : platformTitles;
      return ListView.builder(
        itemCount: titles.length + 1,
        itemBuilder: (BuildContext context, int index) {
          num top;
          if (index == 2) {
            top = ScreenUtil().setHeight(20);
          } else {
            top = ScreenUtil().setHeight(2);
          }
          if (index == 3) {
            return Padding(
              padding: EdgeInsets.only(
                  top: top,
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TLDDetailOrderPayMethodCell(
                title: titles[index],
                titleStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
                isOpen: isOpen,
                paymentModel: _detailModel.payMethodVO,
                didClickCallBack: (){
                  setState(() {
                    isOpen = !isOpen;
                  });
                  if (_detailModel.payMethodVO.type == 2 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailWechatQrCodeShowView(qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,));
                  }else if (_detailModel.payMethodVO.type == 2 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailAlipayQrCodeShowView(qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,));                    
                  }
                },
                didClickQrCodeCallBack: (){
                  if (_detailModel.payMethodVO.type == 2 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailWechatQrCodeShowView(qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,));
                  }else if (_detailModel.payMethodVO.type == 2 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailAlipayQrCodeShowView(qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,));                    
                  }
                },
              ),
            );
          // }else if(index == 5){
          //   return _getIMCell();
          // }else if(index == 6){
          //   return isNeedAppeal ? _getAppealCell(appealTitle) : TLDDetailOrderBottomCell(detailOrderModel:_detailOrderModel,isBuyer: _detailOrderModel.amIBuyer,didClickActionBtnCallBack: (String buttonTitle){
          //     if (buttonTitle == '取消订单'){
          //       _cancelOrder();
          //     }else if(buttonTitle == '我已付款'){
          //       _confirmPaid();
          //     }else if(buttonTitle == '确认释放TLD'){
          //       _sureSentCoin();
          //     }else if (buttonTitle == '催单'){
          //       _remindOrder();
          //     }
          //   },);
          // }else if(index == 7){
          //   return TLDDetailOrderBottomCell(detailOrderModel:_detailOrderModel,isBuyer: _detailOrderModel.amIBuyer,didClickActionBtnCallBack: (String buttonTitle){
          //     if (buttonTitle == '取消订单'){
          //       _cancelOrder();
          //     }else if(buttonTitle == '我已付款'){
          //       _confirmPaid();
          //     }else if(buttonTitle == '确认释放TLD'){
          //       _sureSentCoin();
          //     }else if (buttonTitle == '催单'){
          //       _remindOrder();
          //     }
          //   },);
          }else if(index == titles.length){
            return TLDAcceptanceDetailWithdrawBottomCell(detailModel: _detailModel,);
          }else {
            return _getNormalCell(context, top, index,titles);
          }
        });
    }
  }

  void _getAppealStatusAndAppealTitle(Function(bool,String) callBack){
    //  bool isNeedAppeal = false;
    //  String appealTitle = '';
    // if (_detailOrderModel != null){
    //   switch (_detailOrderModel.status) {
    //     case 1 :{
    //       isNeedAppeal = true;
    //       appealTitle = '订单申诉';
    //     }
    //     break;
    //     default :{         
    //     }
    //     break;
    //     }
    //   }
    // if (_detailOrderModel.appealStatus > -1){
    //   isNeedAppeal = true;
    //   if (_detailOrderModel.appealStatus == 0) {
    //     appealTitle = '订单申诉中';
    //   }else if(_detailOrderModel.appealStatus == 1){
    //     appealTitle = '订单申诉成功';
    //   }else if(_detailOrderModel.appealStatus == 2){
    //     appealTitle = '订单申诉失败';
    //   }else {
    //     appealTitle = '订单申诉';
    //   }
    // }
    // callBack(isNeedAppeal,appealTitle);
    callBack(true , '订单申述中');
  }

  Widget _getNormalCell(BuildContext context, num top, int index,List titles) {
    String content = '';
    if(index == 0){
      content = _detailModel.cashNo;
    }else if(index == 1){
      content = _detailModel.tldCount + 'TLD';
    }else if(index == 2){
      content = '¥'+_detailModel.cashPrice;
    }else if(index == 4){
      content = _detailModel.walletAddress;
    }else if(index == 5){
      content = _detailModel.cashType == 1 ? '推荐人' : '买家';
    }else if(index == 6){
      double rate = double.parse(_detailModel.chargeRate) * 100;
      content = '${rate}%';
    }else if(index == 7){
      content = '${_detailModel.chargeValue}TLD';
    }
    return Padding(
      padding: EdgeInsets.only(
          top: top,
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TLDClipCommonCell(
          type: TLDClipCommonCellType.normal,
          title: titles[index],
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: content,
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    );
  }

  // Widget _getIMCell(){
  //   String title = _detailOrderModel.amIBuyer == true ? '联系卖家' : '联系买家';
  //   return GestureDetector(
  //     onTap: () { 
  //       String toUserName = '';
  //         if (_detailOrderModel.amIBuyer){
  //           toUserName = _detailOrderModel.sellerUserName;
  //         }else{
  //           toUserName = _detailOrderModel.buyerUserName;
  //         }
  //         Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(toUserName: toUserName,orderNo: _detailOrderModel.orderNo,))).then((value){
  //           _getDetailOrderInfo();
  //         });
  //     },
  //     child:  Padding(
  //     padding: EdgeInsets.only(
  //         top: ScreenUtil().setHeight(2),
  //         left: ScreenUtil().setWidth(30),
  //         right: ScreenUtil().setWidth(30)),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.all(Radius.circular(4)),
  //       child: TLDClipCommonCell(
  //         type: TLDClipCommonCellType.normalArrow,
  //         title: title,
  //         titleStyle: TextStyle(
  //             fontSize: ScreenUtil().setSp(24),
  //             color: Color.fromARGB(255, 51, 51, 51)),
  //         content: '',
  //         contentStyle: TextStyle(
  //             fontSize: ScreenUtil().setSp(24),
  //             color: Color.fromARGB(255, 102, 102, 102)),
  //       ),
  //     ),
  //   ),
  //   );
  // }

  // Widget _getAppealCell(String appealTitle){
  //   return GestureDetector(
  //     onTap: () {
  //       _jumpToOrderAppeal();
  //     },
  //     child:  Padding(
  //     padding: EdgeInsets.only(
  //         top: ScreenUtil().setHeight(2),
  //         left: ScreenUtil().setWidth(30),
  //         right: ScreenUtil().setWidth(30)),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.all(Radius.circular(4)),
  //       child: TLDClipCommonCell(
  //         type: TLDClipCommonCellType.normalArrow,
  //         title: appealTitle,
  //         titleStyle: TextStyle(
  //             fontSize: ScreenUtil().setSp(24),
  //             color: Color.fromARGB(255, 51, 51, 51)),
  //         content: '',
  //         contentStyle: TextStyle(
  //             fontSize: ScreenUtil().setSp(24),
  //             color: Color.fromARGB(255, 102, 102, 102)),
  //       ),
  //     ),
  //   ),
  //   );
  // }
}