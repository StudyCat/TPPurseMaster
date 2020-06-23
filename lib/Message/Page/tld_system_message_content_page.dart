import 'dart:async';
import 'dart:convert';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Message/Model/tld_system_message_model_manager.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Page/tld_my_purse_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_system_message_cell.dart';

class TLDSystemMessageContentPage extends StatefulWidget {
  TLDSystemMessageContentPage({Key key}) : super(key: key);

  @override
  _TLDSystemMessageContentPageState createState() => _TLDSystemMessageContentPageState();
}

class _TLDSystemMessageContentPageState extends State<TLDSystemMessageContentPage> with AutomaticKeepAliveClientMixin {

  TLDIMManager _manager;

  int _page;

  List _dataSource = [];

  RefreshController _refreshController;

  StreamSubscription _messageSubscription;

  TLDSystemMessageModelManager _modelManager;

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TLDIMManager.instance;
    _manager.isOnChatPage = true;

    _modelManager = TLDSystemMessageModelManager();

    _refreshController = RefreshController();

    _page = 0;

    _getSystemList(_page);

    registerEvent();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _messageSubscription.cancel();
  }


  void _getSystemList(int page){
     _manager.getSystemMsssageList(page,
        (List messages) {
      if (page == 0) {
        if (mounted){
                  setState(() {
          _dataSource.addAll(messages);
        });
        }
      } else {
        if (mounted){
                  setState(() {
          _dataSource.insertAll(0, messages);
        });
        }
      }
      if (messages.length > 0) {
        _page = page + 1;
      }
      _refreshController.refreshCompleted();
    });
  }

   //注册广播
  void registerEvent(){
    _messageSubscription = eventBus.on<TLDMessageEvent>().listen((event) {
      for (TLDMessageModel item in event.messageList) {
          if (item.messageType == 1){
            _dataSource.add(item);
          }
        }
      setState(() {
        _dataSource;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: SmartRefresher(
      controller: _refreshController,
      header: WaterDropHeader(complete: Container()),
      onRefresh: () => _getSystemList(_page),
      child: ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        TLDMessageModel model = _dataSource[index];
        return Dismissible(
          key: Key(UniqueKey().toString()), 
          child: _getCellWidget(model),
          onDismissed: (DismissDirection direction){
            setState(() {
              _isLoading = true;
            });
            _modelManager.deleteSystemMessage(model.id, (){
              setState(() {
              _isLoading = false;
              });
              _dataSource.remove(model);
            });
          },
          );
     },
    ),
    ),
    );
  }

  Widget _getCellWidget(TLDMessageModel model){
    return GestureDetector(
          onTap:(){
            Map attrMap = jsonDecode(model.bizAttr);
            if ((model.contentType > 99 && model.contentType < 105) || model.contentType == 107){
              String orderNo = attrMap['orderNo'];
              bool isBuyer = false;
              String buyerAddress = attrMap['buyerAddress'];
              List purseList = TLDDataManager.instance.purseList;
              List addressList = [];
              for (TLDWallet item in purseList) {
                addressList.add(item.address);
              }
              if (addressList.contains(buyerAddress)){
                isBuyer = true;
              }
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDDetailOrderPage(orderNo: orderNo,isBuyer: isBuyer,)));
            }else if(model.contentType == 105){
              String address = attrMap['toAddress'];
              List purseList = TLDDataManager.instance.purseList;
                TLDWallet wallet;
                for (TLDWallet item in purseList) {
                  if (item.address == address){
                    wallet = item;
                    break;
                  }
                }
             Navigator.push(context,MaterialPageRoute(builder: (context) => TLDMyPursePage(wallet: wallet,changeNameSuccessCallBack: (str){},)));
            }else if (model.contentType == 106){
              int appealId = attrMap['appealId'];
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDJustNoticePage(appealId: appealId,)));
            }
          },
          child : TLDSystemMessageCell(messageModel: model,)
        );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}