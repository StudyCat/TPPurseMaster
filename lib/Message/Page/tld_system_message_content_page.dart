import 'dart:async';
import 'dart:convert';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_detail_withdraw_page.dart';
import 'package:dragon_sword_purse/Message/Model/tld_system_message_model_manager.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Page/tld_my_purse_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/tld_system_message_cell.dart';

class TLDSystemMessageContentPage extends StatefulWidget {
  TLDSystemMessageContentPage({Key key}) : super(key: key);

  @override
  _TLDSystemMessageContentPageState createState() => _TLDSystemMessageContentPageState();
}

class _TLDSystemMessageContentPageState extends State<TLDSystemMessageContentPage> with AutomaticKeepAliveClientMixin {

  // TLDIMManager _manager;

  List _dataSource = [];

  RefreshController _refreshController;

  StreamSubscription _tabbarClickSubscription;

  TLDSystemMessageModelManager _modelManager;

  bool _isLoading = false;

  StreamSubscription _refreshSubscription;

  TLDNewIMManager _imManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _manager = TLDIMManager.instance;
    // _manager.isOnChatPage = true;

    _modelManager = TLDSystemMessageModelManager();

    _imManager = TLDNewIMManager();

    _refreshController = RefreshController();

    _getSystemList();

    registerEvent();

    
    _imManager.addSystemMessageReceiveCallBack((dynamic message){
       if (mounted){
         setState(() {
           _dataSource.insert(0, message);
         });
       }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _imManager.exitSystemConversation();
    _imManager.removeSystemMessageReceiveCallBack();
    // _messageSubscription.cancel();
    _refreshSubscription.cancel();
    _tabbarClickSubscription.cancel();
  }


  void _getSystemList(){
    int page = _dataSource.length;
    _modelManager.getSystemMessageList(page, (List messageList){
        if (mounted){
        setState(() {
          _dataSource = [];
          _dataSource.addAll(messageList);
        });
        }
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
    });
  }

   //注册广播
  void registerEvent(){
      _refreshSubscription = eventBus.on<TLDRefreshMessageListEvent>().listen((event) {
        if(event.refreshPage == 2 || event.refreshPage == 3){
          _refreshController.requestRefresh();
          _dataSource = [];
          _getSystemList(); 
        }else{
          TLDNewIMManager().exitSystemConversation();
        }
    });

    _tabbarClickSubscription = eventBus.on<TLDBottomTabbarClickEvent>().listen((event) {
      if (event.index != 2){
        TLDNewIMManager().exitSystemConversation();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
      controller: _refreshController,
      header: WaterDropHeader(
      complete : Text('刷新完成')
    ),
      footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("放下加载更多数据");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
      onRefresh: (){
        _dataSource = [];
        _getSystemList();
      },
      onLoading: () => _getSystemList(),
      child: ListView.builder(
      itemCount: _dataSource.length,
      itemBuilder: (BuildContext context, int index) {
        JMTextMessage textMessage = _dataSource[index];
        return Dismissible(
          key: Key(UniqueKey().toString()), 
          child: _getCellWidget(textMessage),
          onDismissed: (DismissDirection direction){
            setState(() {
              _isLoading = true;
            });
            _modelManager.deleteSystemMessage(textMessage.id, (){
              setState(() {
              _isLoading = false;
              });
              _dataSource.remove(textMessage);
            });
          },
          );
     },
    ),
    ),
    );
  }

  Widget _getCellWidget(JMTextMessage textMessage){
    return GestureDetector(
          onTap:(){
            Map attrMap = textMessage.extras;
            int contentType = int.parse(attrMap['contentType']);
            if ((contentType > 99 && contentType < 105) ||contentType == 107 || contentType == 108){
              String orderNo = attrMap['orderNo'];
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDDetailOrderPage(orderNo: orderNo)));
            }else if ((contentType > 199 && contentType < 205) ||contentType == 207 || contentType == 208){
              String cashNo = attrMap['cashNo'];
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceDetailWithdrawPage(cashNo:cashNo,)));
            }else if(contentType == 105){
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
            }else if (contentType == 106){
              int appealId = attrMap['appealId'];
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDJustNoticePage(appealId: appealId,)));
            }
          },
          child : TLDSystemMessageCell(textMessage: textMessage,)
        );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}