import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Order/Model/tld_detail_order_model_manager.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_bottom_cell.dart';
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
  List titles = ['订单号', '数量', '应付款', '收款方式', '付款参考号', '接收地址'];
  bool isOpen = false;
  TLDDetailOrderModelManager _modelManager;
  TLDDetailOrderModel _detailOrderModel;
  StreamController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = StreamController();
    _controller.sink.add(_detailOrderModel);

    _modelManager = TLDDetailOrderModelManager();
    _getDetailOrderInfo();
  }

  void _getDetailOrderInfo(){
    _modelManager.getDetailOrderInfoWithOrderNo(widget.orderNo, (TLDDetailOrderModel detailModel){
      _detailOrderModel = detailModel;
      _controller.sink.add(detailModel);
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _cancelOrder(){
    _modelManager.cancelOrderWithOrderNo(widget.orderNo, (){
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '取消订单成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TLDError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _confirmPaid(){
    _modelManager.confirmPaid(widget.orderNo, _detailOrderModel.buyerAddress,  (){
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '确认我已付款成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TLDError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _sureSentCoin(){
    _modelManager.sureSentCoin(widget.orderNo, _detailOrderModel.sellerAddress,  (){
      _detailOrderModel = null;
      _controller.sink.add(_detailOrderModel);
      _getDetailOrderInfo();
      Fluttertoast.showToast(msg: '确认释放积分成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    },  (TLDError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
      ),
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
        background: TLDDetailOrderHeaderView(detailOrderModel: _detailOrderModel,isBuyer: widget.isBuyer,timeIsOverRefreshUICallBack: (){
          _detailOrderModel = null;
          _controller.sink.add(_detailOrderModel);
          _getDetailOrderInfo();
        },),
      ),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: 8,
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
                isBank: true,
                didClickCallBack: (){
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
              ),
            );
          }else if(index == 6){
            return _getIMCell();
          }else if(index == 7){
            return TLDDetailOrderBottomCell(detailOrderModel:_detailOrderModel,isBuyer: widget.isBuyer,didClickActionBtnCallBack: (String buttonTitle){
              if (buttonTitle == '取消订单'){
                _cancelOrder();
              }else if(buttonTitle == '我已付款'){
                _confirmPaid();
              }else if(buttonTitle == '确认释放积分'){
                _sureSentCoin();
              }
            },);
          }else {
            return _getNormalCell(context, top, index);
          }
        });
  }

  Widget _getNormalCell(BuildContext context, num top, int index) {
    String content;
    if(index == 0){
      content = _detailOrderModel.orderNo;
    }else if(index == 1){
      content = _detailOrderModel.txCount + 'TLD';
    }else if(index == 2){
      content = '¥'+_detailOrderModel.txCount;
    }else if(index == 4){
      content = '';
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
    return Padding(
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
    );
  }
}
