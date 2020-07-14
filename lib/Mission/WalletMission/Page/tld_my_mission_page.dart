import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_mission_hall_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_mission_hall_cell.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDMyMissionPage extends StatefulWidget {
  TLDMyMissionPage({Key key,this.taskWalletId}) : super(key: key);

  final int taskWalletId;

  @override
  _TLDMyMissionPageState createState() => _TLDMyMissionPageState();
}

class _TLDMyMissionPageState extends State<TLDMyMissionPage> with AutomaticKeepAliveClientMixin {

  TLDDoMissionModelManager _modelManager;

  List _dataSource = [];

  int _page;

  StreamController _streamController;

  RefreshController _refreshController;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     _streamController = StreamController();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TLDDoMissionModelManager();

    _page = 1;
    _getMissionBuyList(_page);
  }

  void _getMissionBuyList(int page){
    _modelManager.getMissionBuyList(page, widget.taskWalletId, (List buyList){
       _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1) {
        _dataSource = [];
      }
      _dataSource.addAll(buyList);
      _streamController.add(_dataSource);
      if (buyList.length > 0) {
        _page = page + 1;
      }
    }, (TLDError error) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  void _buyMission(TLDMissionBuyPramaterModel pramaterModel){
     if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.buyMission(pramaterModel, (String orderNo){
       if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '购买任务成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDDetailOrderPage(orderNo: orderNo,))).then((value){
        _page = 1;
        _getMissionBuyList(_page);
      });
    }, (TLDError error){
       if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget());
  }

  Widget _getBodyWidget(){
    return TLDEmptyListView(getListViewCellCallBack: (int index){
      TLDMissionBuyInfoModel infoModel = _dataSource[index];
       return TLDMissionHallCell(model: infoModel,didClickBuyBtnCallBack: (){
         showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TLDMissionHallBuyActionSheet(
                taskWalletId:widget.taskWalletId,
                buyInfoModel: infoModel,
                didClickBuyBtnCallBack: (TLDMissionBuyPramaterModel pramaterModel){
                  _buyMission(pramaterModel);
                },            
              );
         });
      },);
    }, getEmptyViewCallBack: (){
      return TLDEmptyDataView(imageAsset: 'assetss/images/no_data.png', title: '暂无可购买的任务');
    }, streamController: _streamController,
    refreshController: _refreshController,
    refreshCallBack: (){
      _page = 1;
      _getMissionBuyList(_page);
    },
    loadCallBack: (){
      _getMissionBuyList(_page);
    },
    ); 
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}