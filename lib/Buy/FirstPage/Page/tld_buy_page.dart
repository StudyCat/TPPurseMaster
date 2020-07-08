import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_empty_data_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_emty_list_view.dart';
import 'package:dragon_sword_purse/Order/Page/tld_detail_order_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../View/tld_buy_search_field.dart';
import '../View/tld_buy_firstpage_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Order/Page/tld_order_list_page.dart';
import '../View/tld_buy_action_sheet.dart';
import '../../../Message/Page/tld_message_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../Model/tld_buy_model_manager.dart';

class TLDBuyPage extends StatefulWidget {
  TLDBuyPage({Key key}) : super(key: key);

  @override
  _TLDBuyPageState createState() => _TLDBuyPageState();
}

class _TLDBuyPageState extends State<TLDBuyPage> with AutomaticKeepAliveClientMixin {

  TLDBuyModelManager _modelManager;

  RefreshController _refreshController;

  StreamController _streamController;

  bool _isLoading;

  int _page;

  String _keyword;

  List _dataSource;
   
  StreamSubscription _unreadSubscription;

  StreamSubscription _systemSubscription;

  bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = false;
    _modelManager = TLDBuyModelManager();
    _refreshController = RefreshController(initialRefresh: true);
    _streamController = StreamController();
    _page = 1;
    _dataSource = [];
    _haveUnreadMessage = TLDIMManager.instance.unreadMessage.length > 0;
    _registerUnreadMessageEvent();
    _registerSystemMessageEvent();
    _loadBuyList(_keyword, _page);
  }

    void _registerUnreadMessageEvent(){
    _unreadSubscription = eventBus.on<TLDHaveUnreadMessageEvent>().listen((event) {
      setState(() {
        _haveUnreadMessage = event.haveUnreadMessage;
      });
    });
  }

  void _registerSystemMessageEvent(){
    _systemSubscription = eventBus.on<TLDSystemMessageEvent>().listen((event) {
       TLDMessageModel messageModel = event.messageModel;
      if (messageModel.contentType == 100 || messageModel.contentType == 101 || messageModel.contentType == 103){
        _page = 1;
        _loadBuyList(_keyword, _page);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _unreadSubscription.cancel();
    _systemSubscription.cancel();
  }

  void _loadBuyList(String keyword,int page){
    _modelManager.getBuyListData(keyword, page, (List data){
      if(page == 1){
        _dataSource = [];
      }
      _dataSource.addAll(data);
      _streamController.sink.add(_dataSource);      
      if(data.length > 0){
        _page = page + 1;
      }
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg, toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
  }

  void buyTLDCoinWithPramaterModel(TLDBuyPramaterModel pramaterModel){
      setState(() {
        _isLoading = true;
      });
    _modelManager.buyTLDCoin(pramaterModel, (String orderNo){
      if (mounted){
              setState(() {
        _isLoading = false;
      });
      }
      Fluttertoast.showToast(msg: '购买成功',toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDDetailOrderPage(orderNo: orderNo,isBuyer: true,))).then((value){
        _refreshController.requestRefresh();
        _page = 1;
        _loadBuyList(_keyword, _page);
      });
    }, (TLDError error){
      if(mounted){
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(size.width)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'buy_page',
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        transitionBetweenRoutes: false,
        middle: Text('TLD钱包'),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                TLDMoreBtnClickNotification().dispatch(context);
              });
        }),
        automaticallyImplyLeading: false,
        trailing: Container(
          width : ScreenUtil().setWidth(160),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(
                child: Icon(
                  IconData(0xe663, fontFamily: 'appIconFonts'),
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
                padding: EdgeInsets.all(0),
                minSize: 20,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TLDOrderListPage()));
                }),
            MessageButton(isHaveUnReadMessage: _haveUnreadMessage,
              didClickCallBack: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => TLDMessagePage())),
            )
          ],
        )
        ),
      ),
    );
  }

  Widget _getBodyWidget(double screenWidth){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),child: TLDBuySearchField(textFieldDidChangeCallBack: (String text){
          _keyword = text;
        },didClickSearchBtnCallBack: (){
           _page = 1;
          _loadBuyList(_keyword, _page);
        },),),
        Expanded(child: TLDEmptyListView(getListViewCellCallBack:(int index){
        TLDBuyListInfoModel model = _dataSource[index];
          return TLDBuyFirstPageCell(model: model,didClickBuyBtnCallBack: (){
            showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TLDBuyActionSheet(model: model,didClickBuyBtnCallBack: (TLDBuyPramaterModel pramaterModel){
                buyTLDCoinWithPramaterModel(pramaterModel);
              },);
            });
          },);
      }, getEmptyViewCallBack:(){
        return TLDEmptyDataView(imageAsset: 'assetss/images/creating_purse.png', title: '暂无可购买的单子');
      }, streamController: _streamController,
      refreshController: _refreshController,
      refreshCallBack: (){
        _page = 1;
          _loadBuyList(_keyword, _page);
      },loadCallBack: (){
          _loadBuyList(_keyword, _page);
      },))
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
