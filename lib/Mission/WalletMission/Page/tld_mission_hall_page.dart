
import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Mission/DetailMission/Page/tld_detail_mission_page.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_mission_first_mission_cell.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Model/tld_mission_progress_model_manager.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_my_mission_body_cell.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_my_mission_header_cell.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/expention_layout.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDMissionHallPage extends StatefulWidget {
  TLDMissionHallPage({Key key,this.taskWalletId}) : super(key: key);

  final int taskWalletId;


  @override
  _TLDMissionHallPageState createState() => _TLDMissionHallPageState();
}

class _TLDMissionHallPageState extends State<TLDMissionHallPage> with AutomaticKeepAliveClientMixin {
  bool _isOpen = false;

  StreamController _streamController;

  RefreshController _refreshController;

  TLDMissionProgressModelManager _modelManager;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController = StreamController();

    _refreshController = RefreshController(initialRefresh: true);

    _modelManager = TLDMissionProgressModelManager();
    _getMissionProgress();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  void _getMissionProgress(){
    _modelManager.getMissionProgress(widget.taskWalletId, (TLDMissionProgressModel progressModel){
      _refreshController.refreshCompleted();
      if(mounted){
        _streamController.sink.add(progressModel);
      }
    }, (TLDError error){
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamController.stream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        TLDMissionProgressModel model = snapshot.data;
        if (model != null){
          return _haveDataViewBuild(model);
        }else{
          return _emptyDataViewBuild();
        }
      },
    );
  }

  Widget _haveDataViewBuild(TLDMissionProgressModel model){
    // return SmartRefresher(
    //   controller: _refreshController,
    //   header: _refreshHeaderBuild(),
    //   onRefresh: ()=> _getMissionProgress(),
    //   child: Padding(
    //   padding:EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
    //   child :SingleChildScrollView(
    //   child : ExpansionLayoutList(
    //   expandedHeaderPadding: EdgeInsets.zero,
    //   children: <ExpansionPanel>[
    //     ExpansionPanel(headerBuilder: (BuildContext context,bool isOpen){
    //       return TLDMyMissionHeaderCell(progressModel: model,isOpen: _isOpen,didClickOpenBtnCallBack: (){
    //         setState(() {
    //           _isOpen = ! isOpen;
    //         });
    //       },didClickItemCallBack: (){
    //         Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDDetailMissionPage(taskWalletId: widget.taskWalletId,)));
    //       },);
    //     }, body: ListBody(
    //       children: _getExpansionContent(model.taskOrderList, model.taskBuyNo
    //     ),
    //     isExpanded: _isOpen
    //     ),
    //   ],
    // )
    // ) 
    //   ),
    //   );
  }

   Widget _refreshHeaderBuild(){
    return WaterDropHeader(
      complete : Text('刷新完成')
    );
  }

  List<Widget> _getExpansionContent(List orderList,String taskNo){
    List<Widget> result = [];
    for (TaskOrderListModel item in orderList) {
      result.add(TLDMYMissionBodyCell(model: item,taskNo: taskNo,didClickItemCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDDetailOrderPage(orderNo: item.orderNo))).then((value){
          _refreshController.requestRefresh();
          _getMissionProgress();
        });
      },didClickIMBtnCallBack: (){
        String toUserName = '';
        if (item.amIBuyer){
          toUserName = item.sellerUserName;
        }else{
          toUserName = item.buyerUserName;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDIMPage(toUserName: toUserName,orderNo: item.orderNo,))).then((value){
          _refreshController.requestRefresh();
          _getMissionProgress();
        });
      },));
    }
    return result;
  }

  Widget _emptyDataViewBuild(){
    return SmartRefresher(
      controller: _refreshController,
      header: _refreshHeaderBuild(),
      onRefresh: ()=> _getMissionProgress(),
      child: TLDEmptyDataView(imageAsset: 'assetss/images/no_data.png', title: '暂无任务'),
      );
  }

      @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}