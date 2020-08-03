
import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Sale/DetailSale/Model/tld_detail_sale_model.dart';
import 'package:dragon_sword_purse/Sale/DetailSale/Model/tld_detail_sale_model_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../View/tld_detail_sale_info_view.dart';
import '../View/tld_detail_sale_row_view.dart';

class TLDDetailSalePage extends StatefulWidget {
  final String sellNo;
  final String walletName;
  TLDDetailSalePage({Key key,this.sellNo,this.walletName}) : super(key: key);

  @override
  _TLDDetailSalePageState createState() => _TLDDetailSalePageState();
}

class _TLDDetailSalePageState extends State<TLDDetailSalePage> {

  TLDDetailSaleModel _saleModel;

  bool _isLoading;

  // StreamSubscription _systemSubscreption;

  List titles = [
    '收款方式',
    '挂售钱包',
    '最低购买额度',
    '最高购买额度',
    '手续费率',
    '手续费',
    '预计到账',
    '创建时间',
  ];


  TLDDetailSaleModelManager _modelManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TLDDetailSaleModelManager();
    _isLoading = true;

    getDetailInfo();

    // _registerSystemEvent();
    _addSystemMessageCallBack();
  }


  void getDetailInfo(){
    _modelManager.getDetailSale(widget.sellNo, (TLDDetailSaleModel detailModel){
      if (mounted){
              setState(() {
        _isLoading = false;
        _saleModel = detailModel;
      });
      }
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

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // _systemSubscreption.cancel();
    TLDNewIMManager().removeSystemMessageReceiveCallBack();
  }

  void _addSystemMessageCallBack(){
    TLDNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 100 || contentType == 101 || contentType == 103 || contentType == 104){
        setState(() {
          _isLoading = true;
        });
        getDetailInfo();
      }
    });
  }

  // void _registerSystemEvent(){
  //   _systemSubscreption = eventBus.on<TLDSystemMessageEvent>().listen((event) {
  //     TLDMessageModel messageModel = event.messageModel;
  //     if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103 || messageModel.contentType == 104){
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       getDetailInfo();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'detail_sale_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return  Container(
        padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),bottom: ScreenUtil().setHeight(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)), 
          child: Container(
            padding : EdgeInsets.only(left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
            color: Colors.white,
            child :  ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                String address = _saleModel != null ? _saleModel.walletAddress : '';
                return Padding(
                  padding: EdgeInsets.only(top : ScreenUtil().setHeight(36)),
                  child: Text('地址：' + address,style:TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153))),
                );
              }else if (index == 1){
                return TLDDetailSaleInfoView(saleModel: _saleModel,);
              }else{
                bool isShowIcon = false;
                String content  = '';
                int payStatus = 0;
                if (index == 2) {
                  isShowIcon = true;
                  payStatus = _saleModel != null ? _saleModel.payMethodVO.type : 0;
                }else if(index == 3){
                  content = widget.walletName;
                }else if(index == 4){
                  String amount = _saleModel != null ? _saleModel.max : '0';
                  content = amount + 'TLD';  
                }else if (index == 5){
                  String amount = _saleModel != null ? _saleModel.maxAmount : '0';
                  content = amount + 'TLD';  
                }else if(index == 6){
                  content = _saleModel != null ? (_saleModel.rate + '%') : '0.6%'; 
                }else if(index == 7){
                  content = _saleModel != null ? ('¥'+ _saleModel.charge) : '¥0';
                }else if(index == 8){
                  content = _saleModel != null ? ('¥'+ _saleModel.recCount) : '¥0';
                }else{
                  content = _saleModel != null ? formatDate(DateTime.fromMillisecondsSinceEpoch(_saleModel.createTime), [yyyy,'-',mm,'-',dd]): '';
                }
                return TLDDetailSaleRowView(isShowIcon: isShowIcon,title: titles[index - 2],content: content,payStatus: payStatus,);
              }
           },
          )
          ),
        ),
      );
  }
}