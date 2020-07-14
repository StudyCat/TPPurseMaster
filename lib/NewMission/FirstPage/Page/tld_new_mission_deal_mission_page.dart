import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_do_mission_model_manager.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_mission_hall_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_mission_hall_cell.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Model/tld_new_mission_deal_mission_model_manger.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_first_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class TLDNewMissionDealMissionPage extends StatefulWidget {
  TLDNewMissionDealMissionPage({Key key,this.control,this.walletAddress,this.getProgressCallBack}) : super(key: key);

  final TLDNewMissionPageControl control;

  final String walletAddress;

  final Function(String) getProgressCallBack;

  @override
  _TLDNewMissionDealMissionPageState createState() => _TLDNewMissionDealMissionPageState();
}

class _TLDNewMissionDealMissionPageState extends State<TLDNewMissionDealMissionPage> with AutomaticKeepAliveClientMixin {
  TLDNewMissionDealMissionModelManager _modelManager;

  List _dataSource = [];

  int _page;

  StreamController _streamController;

  RefreshController _refreshController;

  bool _isLoading = false;

  String _walletAddress = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     _streamController = StreamController();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TLDNewMissionDealMissionModelManager();

    _walletAddress = widget.walletAddress;

    _page = 1;
    _getMissionBuyList(_page);

    widget.control.addListener(() {
      if (_walletAddress != widget.control.value){
          _walletAddress = widget.control.value;

          _refreshController.requestRefresh();
          _page = 1;
          _getMissionBuyList(_page);
      }
    });
  }


  void _getMissionBuyList(int page){
    if (_walletAddress.length == 0){
      Fluttertoast.showToast(msg: '请先选择钱包');
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      return;
    }
    _modelManager.getMissionBuyList(_walletAddress,page,(List buyList,String progressCount){
       _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (page == 1) {
        _dataSource = [];
      }
      _dataSource.addAll(buyList);
      if (mounted){
        _streamController.add(_dataSource);
      }
      if (buyList.length > 0) {
        _page = page + 1;
      }
      widget.getProgressCallBack(progressCount);
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDDetailOrderPage(orderNo: orderNo))).then((value){
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
                buyInfoModel: infoModel,
                walletAddress: _walletAddress,
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