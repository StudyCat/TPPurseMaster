import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../View/message_button.dart';
import '../View/purse_first_cell.dart';
import '../View/purse_cell.dart';
import '../View/purse_bottom_cell.dart';
import '../../MyPurse/Page/tld_my_purse_page.dart';
import '../../../ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import '../../../ceatePurse&importPurse/ImportPurse/Page/tld_import_purse_page.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Message/Page/tld_message_page.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../CommonFunction/tld_common_function.dart';
import '../Model/tld_purse_model_manager.dart';

class TLDPursePage extends StatefulWidget {
  TLDPursePage({Key key,this.didClickMoreBtnCallBack}) : super(key: key);
  final Function didClickMoreBtnCallBack;

  @override
  _TLDPursePageState createState() => _TLDPursePageState();
}

class _TLDPursePageState extends State<TLDPursePage> with AutomaticKeepAliveClientMixin {
  TLDPurseModelManager _manager;

  List _dataSource;

  double _totalAmount;

  RefreshController _controller;

  StreamSubscription _unreadSubscription;

  bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TLDPurseModelManager();

    _dataSource = [];

    _totalAmount = 0.0;

    _controller = RefreshController(initialRefresh: true);

    _haveUnreadMessage = TLDIMManager.instance.unreadMessage.length > 0;

    _registerUnreadMessageEvent();

    _getPurseInfoList(context);
  }

  void _registerUnreadMessageEvent(){
    _unreadSubscription = eventBus.on<TLDHaveUnreadMessageEvent>().listen((event) {
      setState(() {
        _haveUnreadMessage = event.haveUnreadMessage;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _unreadSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _controller,
        child: _getBodyWidget(context),
        header: WaterDropHeader(complete: Text('刷新完成'),),
        onRefresh:()=>_getPurseInfoList(context),
        ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包',style: TextStyle(color : Colors.white),),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TLDMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
        trailing: MessageButton(color : Colors.white,isHaveUnReadMessage: _haveUnreadMessage,didClickCallBack: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TLDMessagePage()));
        }),
      ),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _getListViewItem(context,index),
      itemCount: _dataSource.length + 2,
    );
  }

  Widget _getListViewItem(BuildContext context, int index) {
    if (index == 0) {
      return TLDPurseHeaderCell(totalAmount:  _totalAmount,
        didClickCreatePurseButtonCallBack: (){
          _createPurse(context);
        },
        didClickImportPurseButtonCallBack: (){
          _importPurse(context);
        },
        );
    } else if (index == _dataSource.length + 1) {
      return TLDPurseFirstPageBottomCell();
    } else {
      TLDWalletInfoModel model = _dataSource[index - 1];
      return TLDPurseFirstPageCell(
        walletInfo: model,
        didClickCallBack: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  TLDMyPursePage(wallet: model.wallet,changeNameSuccessCallBack: (String name){
                  setState(() {
                    TLDDataManager.instance.purseList;
                  });
                },);
              },
            ),
          ).then((value) => _getPurseInfoList(context));
        },
      );
    }
  }

  void _createPurse(BuildContext context){
    jugeHavePassword(context, (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDCreatingPursePage(type: TLDCreatingPursePageType.create,)));
    },TLDCreatePursePageType.create,null);
  }

  void _importPurse(BuildContext context){
    jugeHavePassword(context,(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDImportPursePage()));
    },TLDCreatePursePageType.import,null);
  }

  void _getPurseInfoList(BuildContext context){
    _manager.getWalletListData((List purseInfoList){
      _totalAmount = 0.0;
      _dataSource = [];
      if (mounted){
              setState(() {
        for (TLDWalletInfoModel item in purseInfoList) {
          _totalAmount = _totalAmount + double.parse(item.value);
        }
        _dataSource = List.from(purseInfoList);
      });
      }
      _controller.refreshCompleted();
    }, (TLDError error){
      _controller.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1);
    });
  }

    @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
}
