
import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Model/tld_sale_list_info_model.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/View/tld_sale_suspend_button.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_sale_firstpage_cell.dart';
import '../../DetailSale/Page/tld_detail_sale_page.dart';
import '../View/tld_sale_not_data_view.dart';
import '../Model/tld_sale_model_manager.dart';
import '../../../Exchange/FirstPage/Page/tld_exchange_page.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDSalePage extends StatefulWidget {
  TLDSalePage({Key key,this.type}) : super(key: key);

  final int type;

  @override
  _TLDSalePageState createState() => _TLDSalePageState();
}

class _TLDSalePageState extends State<TLDSalePage> with AutomaticKeepAliveClientMixin {
  List _saleDatas;

  TLDSaleModelManager _modelManager;

  RefreshController _refreshController;

  bool _isLoading;

  StreamSubscription _systemSubscreption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modelManager = TLDSaleModelManager();
     _saleDatas = [];
    _isLoading = false;

    _refreshController = RefreshController(initialRefresh: true);

    getSaleListInfo();

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
        _refreshController.requestRefresh();
        getSaleListInfo();
      }
    });
  }

  void getSaleListInfo(){
    _modelManager.getSaleList(widget.type,(List dataList){
      if (mounted){
              setState(() {
        _saleDatas = List.from(dataList);
      });
      }
      _refreshController.refreshCompleted();
    } , (TLDError error) {
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

    void _cancelSale(TLDSaleListInfoModel model,int index){
    setState(() {
      _isLoading = true;
    });
    _modelManager.cancelSale(model, (){
      if (mounted){
              setState(() {
      _isLoading = false;
      _saleDatas.removeAt(index);
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
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: _getBody());
  }

  Widget _getRsfreshWidget(Widget widget){
    return SmartRefresher(
      controller:_refreshController,
      header: WaterDropHeader(complete: Text('刷新完成')),
      onRefresh: ()=> getSaleListInfo(),
      child: widget, 
      );
  }

  Widget _getBody() {
    if (_saleDatas.length > 0){
      return Stack(
              alignment: FractionalOffset(0.9, 0.95),
              children: <Widget>[
              _getRsfreshWidget(ListView.builder(
              itemCount: _saleDatas.length,
              itemBuilder: (BuildContext context, int index) {
                TLDSaleListInfoModel model = _saleDatas[index];
                return getSaleFirstPageCell(
                    '取消挂售',
                    () => _cancelSale(model,index),
                    context,model,()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDDetailSalePage(sellNo: model.sellNo,walletName: model.wallet.name,))),widget.type);
              },
             )),
             TLDSaleSuspendButton(didClickCallBack:(){
               Navigator.push(context, MaterialPageRoute(builder: (context) => TLDExchangePage())).then((dynamic value){
              _refreshController.requestRefresh();
              getSaleListInfo();
            });
             } ,)
              ],
            );
    }else{
      return _getRsfreshWidget(TLDSaleNotDataView(didClickCallBack: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TLDExchangePage())).then((dynamic value){
              _refreshController.requestRefresh();
              getSaleListInfo();
            });
          },));
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
