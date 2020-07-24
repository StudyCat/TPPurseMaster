import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_order_list_cell.dart';
import 'tld_detail_order_page.dart';
import '../../IMUI/Page/tld_im_page.dart';
import '../Model/tld_order_list_model_manager.dart';

class TLDOrderListContentController  extends ValueNotifier<int>{
    TLDOrderListContentController(int status) : super(status);
}


class TLDOrderListContentPage extends StatefulWidget {
  TLDOrderListContentPage({Key key,this.type,this.controller,this.walletAddress}) : super(key: key);

  final String walletAddress;

  final int type;

  final TLDOrderListContentController controller;

  @override
  _TLDOrderListContentPageState createState() => _TLDOrderListContentPageState();
}

class _TLDOrderListContentPageState extends State<TLDOrderListContentPage> with AutomaticKeepAliveClientMixin {

  TLDOrderListModelManager _modelManager;

  TLDOrderListPramaterModel _pramaterModel;

  List _dataSource;

  RefreshController _refreshController;

  // StreamSubscription _systemSubscreption;

  StreamController _streamController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TLDOrderListModelManager();

    _pramaterModel = TLDOrderListPramaterModel();
    _pramaterModel.type = widget.type;
    _pramaterModel.page = 1;
    if (widget.walletAddress != null){
      _pramaterModel.walletAddress =  widget.walletAddress;
    }

    _dataSource = [];

    _refreshController = RefreshController(initialRefresh:true);

    _streamController = StreamController();

    _getOrderListDataWithPramaterModel(_pramaterModel);

    widget.controller.addListener(() {
      int status = widget.controller.value;
      if (status == null){
        if (_pramaterModel.status != null){
          _pramaterModel.status = null;
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        }
      }else{
        if (_pramaterModel.status != status){
           _pramaterModel.status = status;
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        }
      }
    });
    
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

  @override
  Widget build(BuildContext context) {
    return TLDEmptyListView(
      getListViewCellCallBack:(int index){
        return _getListItem(context, index);
      } , getEmptyViewCallBack: (){
        return TLDEmptyDataView(imageAsset: 'assetss/images/creating_purse.png', title: '暂无订单');
      }, streamController: _streamController,
      refreshController: _refreshController,
      refreshCallBack: (){
        _pramaterModel.page = 1;
        _getOrderListDataWithPramaterModel(_pramaterModel);
      },loadCallBack: (){
        _getOrderListDataWithPramaterModel(_pramaterModel);
      },);
  }

  Widget _getListItem(BuildContext context,int index){
    TLDOrderListModel model = _dataSource[index];
    bool isBuyer =  widget.type == 1 ? true : false;
    // String selfAddress = isBuyer == true ? model.buyerAddress : model.sellerAddress;
    //  String otherAddress = isBuyer == false ? model.buyerAddress : model.sellerAddress;
    return TLDOrderListCell(
      orderListModel: model,
      didClickDetailBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailOrderPage(orderNo: model.orderNo,))).then((value) {
          _pramaterModel.page = 1;
          _refreshController.requestRefresh();
          _getOrderListDataWithPramaterModel(_pramaterModel);
        });
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
      );
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}