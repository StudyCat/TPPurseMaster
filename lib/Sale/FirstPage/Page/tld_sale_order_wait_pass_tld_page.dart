import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_appeal_page.dart';
import 'package:dragon_sword_purse/Order/View/tld_order_list_cell.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDSaleOrderWaitTLDPage extends StatefulWidget {
  TLDSaleOrderWaitTLDPage({Key key}) : super(key: key);

  @override
  _TLDSaleOrderWaitTLDPageState createState() => _TLDSaleOrderWaitTLDPageState();
}

class _TLDSaleOrderWaitTLDPageState extends State<TLDSaleOrderWaitTLDPage>  {
 
  TLDOrderListModelManager _modelManager;

  TLDOrderListPramaterModel _pramaterModel;

  List _dataSource;

  RefreshController _refreshController;

  bool _isLoading = false;

  // StreamSubscription _systemSubscreption;

  StreamController _streamController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TLDOrderListModelManager();

    _pramaterModel = TLDOrderListPramaterModel();
    _pramaterModel.type = 2;
    _pramaterModel.page = 1;
    _pramaterModel.status = 1;

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh:true);

    _streamController = StreamController();

    _getOrderListDataWithPramaterModel(_pramaterModel);
    
    // _registerSystemEvent();

    _addSystemMessageCallBack();
  }

    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TLDNewIMManager().removeSystemMessageReceiveCallBack();
    // _systemSubscreption.cancel();
  }

    void _addSystemMessageCallBack(){
    TLDNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 100 || contentType == 101 || contentType == 103 || contentType == 104){
        _pramaterModel.page = 1;
        _refreshController.requestRefresh();
        _getOrderListDataWithPramaterModel(_pramaterModel);
      }
    });
  }

  // void _registerSystemEvent(){
  //   _systemSubscreption = eventBus.on<TLDSystemMessageEvent>().listen((event) {
  //     TLDMessageModel messageModel = event.messageModel;
  //     if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103 || messageModel.contentType == 104){
  //       _pramaterModel.page = 1;
  //       _refreshController.requestRefresh();
  //       _getOrderListDataWithPramaterModel(_pramaterModel);
  //     }
  //   });
  // }

  void _getOrderListDataWithPramaterModel(TLDOrderListPramaterModel model){
    _modelManager.getOrderList(model, (List orderList){
      if(model.page == 1){
        _dataSource = [];
         _streamController.sink.add(_dataSource);
      }
       _dataSource.addAll(orderList);
       _streamController.sink.add(_dataSource);
      if (orderList.length > 0){
        _pramaterModel.page = model.page + 1;
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
  }

  void _sureSentCoin(String orderNo,String sellerAddress){
    jugeHavePassword(context, (){
      _sentCoin(orderNo,sellerAddress);
    }, TLDCreatePursePageType.back, (){
      _sentCoin(orderNo,sellerAddress);
    });
  }

  void _sentCoin(String orderNo,String sellerAddress){
     setState(() {
      _isLoading = true;
    });
    _modelManager.sureSentCoin(orderNo, sellerAddress,  (){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      _pramaterModel.page = 1;
      _refreshController.requestRefresh();
      _getOrderListDataWithPramaterModel(_pramaterModel);
      Fluttertoast.showToast(msg: I18n.of(context).sureReleaseTLDSuccessMessage,toastLength: Toast.LENGTH_SHORT,
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
    return LoadingOverlay(isLoading: _isLoading, child: TLDEmptyListView(
      getListViewCellCallBack:(int index){
        return _getListItem(context, index);
      } , getEmptyViewCallBack: (){
        return TLDEmptyDataView(imageAsset: 'assetss/images/creating_purse.png', title: I18n.of(context).noOrderLabel);
      }, streamController: _streamController,
      refreshController: _refreshController,
      refreshCallBack: (){
        _pramaterModel.page = 1;
        _getOrderListDataWithPramaterModel(_pramaterModel);
      },loadCallBack: (){
        _getOrderListDataWithPramaterModel(_pramaterModel);
      },));
  }

  Widget _getListItem(BuildContext context,int index){
    TLDOrderListModel model = _dataSource[index];
    bool isBuyer =  false;
    // String selfAddress = isBuyer == true ? model.buyerAddress : model.sellerAddress;
    //  String otherAddress = isBuyer == false ? model.buyerAddress : model.sellerAddress;
    return TLDOrderListCell(
      orderListModel: model,
      actionBtnTitle: I18n.of(context).releaseTLDBtnTitle,
      didClickDetailBtnCallBack: (){
        _sureSentCoin(model.orderNo, model.sellerAddress);
        },
      didClickIMBtnCallBack: (){
         String toUserName = '';
          if (model.amIBuyer){
            toUserName = model.sellerUserName;
          }else{
            toUserName = model.buyerUserName;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(toUserName: toUserName,orderNo: model.orderNo,))).then((value) {
            _pramaterModel.page = 1;
            _refreshController.requestRefresh();
            _getOrderListDataWithPramaterModel(_pramaterModel);
          });
      },
      didClickItemCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailOrderPage(orderNo: model.orderNo,))).then((value) {
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        });
      },
      didClickAppealBtn: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDJustNoticePage(appealId: model.appealId,type: TLDJustNoticePageType.appealWatching,))).then((value){
            _pramaterModel.page = 1;
            _getOrderListDataWithPramaterModel(_pramaterModel);
         });
      },
      );
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}