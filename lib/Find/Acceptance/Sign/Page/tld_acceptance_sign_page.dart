import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_login_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_sign_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_acceptance_profit_spill_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_acceptance_sign_son_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_body_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_header_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_profit_list_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_list_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_tab_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDAcceptanceSignPage extends StatefulWidget {
  TLDAcceptanceSignPage({Key key}) : super(key: key);


  @override
  _TLDAcceptanceSignPageState createState() => _TLDAcceptanceSignPageState();
}

class _TLDAcceptanceSignPageState extends State<TLDAcceptanceSignPage> with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin {
  TLDAcceptanceSignModelManager _modelManager;

  bool _isLoading = false;

  RefreshController _refreshController;

  TLDAcceptanceUserInfoModel _userInfoModel;

  StreamSubscription _refreshSubscription;

  TabController _tabController;

  List<String> _tabTitles = [
    "提现待支付",
    '提现待释放'
  ];



  @override
  void initState() { 
    super.initState();

    _refreshController = RefreshController(initialRefresh: true);

    _tabController = TabController(length: 2, vsync: this);

    _modelManager = TLDAcceptanceSignModelManager();
    _getUserInfo();

    _registerEvent();
  }

  void _registerEvent(){
    _refreshSubscription = eventBus.on<TLDAcceptanceTabbarClickEvent>().listen((event) {
       if (event.index == 3){
         _refreshController.requestRefresh();
         _getUserInfo();
       }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _refreshSubscription.cancel();
  }

  void _getUserInfo(){
    _modelManager.getUserInfo((TLDAcceptanceUserInfoModel userInfoModel){
      _refreshController.refreshCompleted();
      if(mounted){
      setState(() {
       _userInfoModel = userInfoModel;
      });
      }
    }, (TLDError error){
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_sign_page',
        transitionBetweenRoutes: false,
        automaticallyImplyLeading: false,
        middle: Text('TLD票据账户',style: TextStyle(color:Colors.white),),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
        trailing: GestureDetector(
          onTap :(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceWithdrawTabPage()));
          },
          child : Text('提现记录',style: TextStyle(color:Colors.white,))
        ),
      ),
      body: _getBody(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    bool offstage = true;
    if (_userInfoModel != null) {
      if (_userInfoModel.expireDayCountDesc.length > 0) {
        offstage = false;
      }
    }
    return Column(
      children: <Widget>[
        TLDAcceptanceSignHeaderView(userInfoModel: _userInfoModel,didClickLoginCallBack: (bool isSign){
          if (isSign) {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>TLDAcceptanceSignSonPage(userInfoModel: _userInfoModel,)));
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context) =>TLDAcceptanceLoginPage()));
          }
        },
        didClickWithdrawButtonCallBack: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>TLDAcceptanceWithdrawPage(walletAddress: _userInfoModel.walletAddress,))).then((value){
            eventBus.fire(TLDAcceptaceWithDrawOrderListRefreshEvent());
          });
        },
        didClickProfitCallBack: (String title){
          if (title == '收益溢出池') {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>TLDAcceptanceProfitSpillPage(walletAddress: _userInfoModel.walletAddress,)));
          }else {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TLDAcceptanceProfitListPage()));
          }
        },
        ),
        Offstage(
          offstage: offstage,
          child: Container(
            color : Theme.of(context).hintColor,
            height: ScreenUtil().setHeight(60),
            width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
            child: Center(
              child: Text(_userInfoModel != null ? _userInfoModel.expireDayCountDesc : '',style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 139, 87, 42)),),
            ),
          ),
        ),
         Padding(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(50),
                right: ScreenUtil().setWidth(50),
                top: ScreenUtil().setHeight(20)),
            child: TabBar(
              tabs: _tabTitles.map((title) {
                return Tab(text: title);
              }).toList(),
              labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
              indicatorColor: Theme.of(context).hintColor,
              labelColor: Color.fromARGB(255, 51, 51, 51),
              unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
          Expanded(
              child: TabBarView(
            children: [
              TLDAcceptanceWithdrawListPage(type: TLDAcceptanceProfitListPageType.waitPay,),
              TLDAcceptanceWithdrawListPage(type: TLDAcceptanceProfitListPageType.waitSentTLD,)
            ],
            controller: _tabController,
          ))
        // TLDAcceptanceSignBodyView(userInfoModel: _userInfoModel,didClickSignButton: (){
        //   _sign();
        // },
        // didClickWalletButton: (){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDEchangeChooseWalletPage(
        //     didChooseWalletCallBack: (TLDWalletInfoModel infoModel){
        //       _changeWallet(infoModel);
        //     },
        //   )));
        // },)
      ],
    );
  }

  Widget _getBody(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(60),
          color: Theme.of(context).primaryColor,
        ),
        SmartRefresher(
        controller: _refreshController,
        header: WaterDropHeader(complete: Text('刷新完成'),),
        onRefresh: () => _getUserInfo(),
        child: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(),), 
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}