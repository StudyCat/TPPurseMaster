import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Model/tld_my_purse_model_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_my_purse_recod_cell.dart';
import 'package:flutter/cupertino.dart';

class TLDMyPurseRecordPage extends StatefulWidget {
  TLDMyPurseRecordPage({Key key,this.type,this.walletAddress}) : super(key: key);
  final int type;
  final String walletAddress;
  @override
  _TLDMyPurseRecordPageState createState() => _TLDMyPurseRecordPageState();
}

class _TLDMyPurseRecordPageState extends State<TLDMyPurseRecordPage> with AutomaticKeepAliveClientMixin {
  TLDMyPurseModelManager _manager;

  int _page;

  List _dataSource;

  RefreshController _refreshController;

  StreamSubscription _systemSubscreiption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _page = 1;

    _dataSource = [];

    _manager = TLDMyPurseModelManager();

    _refreshController = RefreshController(initialRefresh:true);

    _getPurseTransferList(_page);

    _registerSystemEvent();
  }

  void _registerSystemEvent(){
    _systemSubscreiption = eventBus.on<TLDSystemMessageEvent>().listen((event) {
      TLDMessageModel messageModel = event.messageModel;
      if (messageModel.contentType == 105){
        _page = 1;
        _refreshController.requestRefresh();
        _getPurseTransferList(_page);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _systemSubscreiption.cancel();
  }

  void _getPurseTransferList(int page){
    _manager.getPurseTransferList(_page, widget.type, widget.walletAddress, (List value){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if(page == 1){
        _dataSource = [];
      }
      setState(() {
        _dataSource.addAll(value);
      });
      if (value.length > 0){
        _page = page + 1;
      }
    }, (TLDError error){
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      Fluttertoast.showToast(msg: error.msg,toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top :ScreenUtil().setHeight(20)),
      child:  SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(
        complete: Text('刷新完成'),
      ),
      footer: _getRefreshFooter(),
      onRefresh: (){
        _page = 1;
        _getPurseTransferList(_page);
      },
      onLoading: (){
        _getPurseTransferList(_page);
      },
      child: getListView(),
    ),
    );
  }

   Widget _getRefreshFooter(){
    return CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        );
  }

  Widget getListView(){
    return ListView.builder(
        itemCount: _dataSource.length,
        itemBuilder: (BuildContext context , int index){
          TLDPurseTransferInfoModel infoModel = _dataSource[index];
          return TLDMyPurseRecordCell(transferInfoModel: infoModel,walletAddress: widget.walletAddress,);
      });
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}