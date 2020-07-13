import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_appeal_page.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_alipay_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_bottom_cell.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_wechat_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../View/tld_detail_order_header.dart';
import '../../CommonWidget/tld_clip_common_cell.dart';
import '../View/tld_detail_order_paymethod_cell.dart';

class TLDDetailOrderPage extends StatefulWidget {
  TLDDetailOrderPage({Key key,this.orderNo,this.isBuyer}) : super(key: key);

  final String orderNo;

  final bool isBuyer;

  @override
  _TLDDetailOrderPageState createState() => _TLDDetailOrderPageState();
}

class _TLDDetailOrderPageState extends State<TLDDetailOrderPage> {
  List titles = ['订单号', '数量', '应付款', '收款方式', '接收地址'];
  bool isOpen = false;
  TLDDetailOrderModelManager _modelManager;
  TLDDetailOrderModel _detailOrderModel;
  StreamController _controller;
  bool _isLoading;
  StreamSubscription _systemSubscreption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = StreamController();
    _controller.sink.add(_detailOrderModel);

    _modelManager = TLDDetailOrderModelManager();
    _isLoading = false;
    _getDetailOrderInfo();

    _registerSystemEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _systemSubscreption.cancel();
  }

  void _registerSystemEvent(){
    _systemSubscreption = eventBus.on<TLDSystemMessageEvent>().listen((event) {
      TLDMessageModel messageModel = event.messageModel;
      if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103 || messageModel.contentType == 104){
        _getDetailOrderInfo();
      }
    });
  }

  void _getDetailOrderInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getDetailOrderInfoWithOrderNo(widget.orderNo, (TLDDetailOrderModel detailModel){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = detailModel;
      _controller.sink.add(detailModel);
    }, (TLDError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _cancelOrder(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.cancelOrderWithOrderNo(widget.orderNo, (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '取消订单成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TLDError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _confirmPaid(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.confirmPaid(widget.orderNo, _detailOrderModel.buyerAddress,  (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '确认我已付款成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TLDError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _sureSentCoin(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.sureSentCoin(widget.orderNo, _detailOrderModel.sellerAddress,  (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '确认释放TLD成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TLDError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _remindOrder(){
     setState(() {
      _isLoading = true;
    });
    _modelManager.remindOrder(widget.orderNo, (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: '催单成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TLDError error){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading:_isLoading, child: StreamBuilder(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          TLDDetailOrderModel model = snapshot.data;
          if (model == null){
            return LoadingOverlay(isLoading: true, child: Container());
          }else{
            return  NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_getAppBar()];
          },
          body: _getBodyWidget(context)
          );
          }
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
        background: TLDDetailOrderHeaderView(detailOrderModel: _detailOrderModel,isBuyer: widget.isBuyer,
        didClickChatBtnCallBack: (){
          // String selfAddress = widget.isBuyer == true ? _detailOrderModel.buyerAddress : _detailOrderModel.sellerAddress;
          // String otherAddress = widget.isBuyer == false ? _detailOrderModel.buyerAddress : _detailOrderModel.sellerAddress;
          // Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(selfWalletAddress: selfAddress,otherGuyWalletAddress: otherAddress,orderNo: _detailOrderModel.orderNo,))).then((value){
          //   _getDetailOrderInfo();
          // });
        },
        timeIsOverRefreshUICallBack: (){
          _detailOrderModel = null;
          _controller.sink.add(_detailOrderModel);
          _getDetailOrderInfo();
        },didClickAppealBtnCallBack: (){
         _jumpToOrderAppeal();
        },
        ),
      ),
    );
  }

  void _jumpToOrderAppeal(){
     if (_detailOrderModel.appealId == -1) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDOrderAppealPage(orderModel: _detailOrderModel,))).then((value) => _getDetailOrderInfo());
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDJustNoticePage(appealId: _detailOrderModel.appealId,type: TLDJustNoticePageType.appealWatching,))).then((value) => _getDetailOrderInfo());
          }
  }

  Widget _getBodyWidget(BuildContext context) {
   bool isNeedAppeal = false;
    String appealTitle = '';
    _getAppealStatusAndAppealTitle((bool isNeed, String title){
      isNeedAppeal = isNeed;
      appealTitle = title;
    });
    return ListView.builder(
        itemCount: isNeedAppeal ? 8 : 7,
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
                paymentModel: _detailOrderModel.payMethodVO,
                didClickCallBack: (){
                  setState(() {
                    isOpen = !isOpen;
                  });
                  if (_detailOrderModel.payMethodVO.type == 2 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailWechatQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));
                  }else if (_detailOrderModel.payMethodVO.type == 2 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailAlipayQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));                    
                  }
                },
                didClickQrCodeCallBack: (){
                  if (_detailOrderModel.payMethodVO.type == 2){
                      showDialog(context: context,builder: (context) => TLDDetailWechatQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));
                  }else{
                      showDialog(context: context,builder: (context) => TLDDetailAlipayQrCodeShowView(qrCode: _detailOrderModel.payMethodVO.imageUrl,amount: _detailOrderModel.txCount,));                    
                  }
                },
              ),
            );
          }else if(index == 5){
            return _getIMCell();
          }else if(index == 6){
            return isNeedAppeal ? _getAppealCell(appealTitle) : TLDDetailOrderBottomCell(detailOrderModel:_detailOrderModel,isBuyer: widget.isBuyer,didClickActionBtnCallBack: (String buttonTitle){
              if (buttonTitle == '取消订单'){
                _cancelOrder();
              }else if(buttonTitle == '我已付款'){
                _confirmPaid();
              }else if(buttonTitle == '确认释放TLD'){
                _sureSentCoin();
              }else if (buttonTitle == '催单'){
                _remindOrder();
              }
            },);
          }else if(index == 7){
            return TLDDetailOrderBottomCell(detailOrderModel:_detailOrderModel,isBuyer: widget.isBuyer,didClickActionBtnCallBack: (String buttonTitle){
              if (buttonTitle == '取消订单'){
                _cancelOrder();
              }else if(buttonTitle == '我已付款'){
                _confirmPaid();
              }else if(buttonTitle == '确认释放TLD'){
                _sureSentCoin();
              }else if (buttonTitle == '催单'){
                _remindOrder();
              }
            },);
          }else {
            return _getNormalCell(context, top, index);
          }
        });
  }

  void _getAppealStatusAndAppealTitle(Function(bool,String) callBack){
     bool isNeedAppeal = false;
     String appealTitle = '';
    if (_detailOrderModel != null){
      switch (_detailOrderModel.status) {
        case 1 :{
          isNeedAppeal = true;
          appealTitle = '订单申诉';
        }
        break;
        default :{         
        }
        break;
        }
      }
    if (_detailOrderModel.appealStatus > -1){
      isNeedAppeal = true;
      if (_detailOrderModel.appealStatus == 0) {
        appealTitle = '订单申诉中';
      }else if(_detailOrderModel.appealStatus == 1){
        appealTitle = '订单申诉成功';
      }else if(_detailOrderModel.appealStatus == 2){
        appealTitle = '订单申诉失败';
      }else {
        appealTitle = '订单申诉';
      }
    }
    callBack(isNeedAppeal,appealTitle);
  }

  Widget _getNormalCell(BuildContext context, num top, int index) {
    String content;
    if(index == 0){
      content = _detailOrderModel.orderNo;
    }else if(index == 1){
      content = _detailOrderModel.txCount + 'TLD';
    }else if(index == 2){
      content = '¥'+_detailOrderModel.txCount;
    }else{
      content = _detailOrderModel.buyerAddress;
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

  Widget _getIMCell(){
    String title = widget.isBuyer == true ? '联系卖家' : '联系买家';
    // String selfAddress = widget.isBuyer == true ? _detailOrderModel.buyerAddress : _detailOrderModel.sellerAddress;
    // String otherAddress = widget.isBuyer == false ? _detailOrderModel.buyerAddress : _detailOrderModel.sellerAddress;
    return GestureDetector(
      onTap: () { 
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(toUserName: 'e2c8faa034ce4272aecf94a8a216cb2f',orderNo: _detailOrderModel.orderNo,))).then((value) => _getDetailOrderInfo());
      },
      child:  Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(2),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TLDClipCommonCell(
          type: TLDClipCommonCellType.normalArrow,
          title: title,
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: '',
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    ),
    );
  }

  Widget _getAppealCell(String appealTitle){
    return GestureDetector(
      onTap: () {
        _jumpToOrderAppeal();
      },
      child:  Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(2),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TLDClipCommonCell(
          type: TLDClipCommonCellType.normalArrow,
          title: appealTitle,
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: '',
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    ),
    );
  }

}
