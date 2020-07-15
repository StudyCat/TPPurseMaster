
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_payment_choose_wallet.dart';
import 'package:dragon_sword_purse/Drawer/UserAgreement/Page/tld_user_agreement_page.dart';
import 'package:dragon_sword_purse/Find/RootPage/Page/tld_find_root_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/Page/tld_mission_first_root_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_first_page.dart';
import 'package:dragon_sword_purse/Purse/TransferAccounts/Page/tld_transfer_accounts_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Page/tld_tab_sale_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_creating_purse_page.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './Buy/FirstPage/Page/tld_buy_page.dart';
import './Purse/FirstPage/Page/tld_purse_page.dart';
import 'Purse/FirstPage/View/purse_firstpage_sideslip.dart';
import 'Notification/tld_more_btn_click_notification.dart';
import 'Drawer/IntegrationDesc/Page/tld_integration_desc_page.dart';
import 'Drawer/AboutUs/Page/tld_about_us_page.dart';
import 'Drawer/UserFeedback/Page/tld_user_feedback_page.dart';
import 'package:uni_links/uni_links.dart';


class TLDTabbarPage extends StatefulWidget {
  TLDTabbarPage({Key key}) : super(key: key);

  @override
  _TLDTabbarPageState createState() => _TLDTabbarPageState();
}

class _TLDTabbarPageState extends State<TLDTabbarPage> with WidgetsBindingObserver {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_purse.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_purse_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text(
        '钱包',
        style: TextStyle(fontSize: 10),
      ),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_buy.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_buy_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('购买',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_message.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_message_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('消息',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_sale.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_sale_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('售卖',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_find.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_find_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('发现',
          style: TextStyle(
            fontSize: 10,
          ))
    )
  ];

  List pages = [TLDPursePage(), TLDBuyPage(), TLDMessagePage(),TLDTabSalePage(),TLDFindRootPage()];

  int currentIndex;

  PageController _pageController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    currentIndex = 0;
    _pageController = PageController();
    
    _loginIM();

    _initPlatformStateForStringUniLinks();
  }

  _loginIM()async{
    String username = await TLDDataManager.instance.getUserName();
    String password = await TLDDataManager.instance.getPassword();
    if (username != null && password != null){
          TLDNewIMManager().loginJpush(username, password);
    }
  }
  
  //处理外部应用调起屠龙刀
   _initPlatformStateForStringUniLinks() async {
    // Get the latest link
    String initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      if (initialLink == null) {
        return;
      }
      if (initialLink == TLDDataManager.instance.lastLink) {
        return;
      }
      TLDDataManager.instance.lastLink = initialLink;
      Uri uri = Uri.parse(initialLink);
      Map queryParameter = uri.queryParameters;
      if (queryParameter.containsKey('path')) {
        String path = queryParameter['path'];
        if (path == 'createWallet') {
        jugeHavePassword(context, (){
          Future.delayed(Duration.zero,(){
             navigatorKey.currentState.push(MaterialPageRoute(builder: (context)=> TLDCreatingPursePage(type: TLDCreatingPursePageType.create,)));
          });
        },TLDCreatePursePageType.create,null);
        }else if(path == 'transferAccounts'){
          thirdAppTransferAccount(queryParameter, (){
            navigatorKey.currentState.push(MaterialPageRoute(builder: (context)=> TLDTransferAccountsPage(thirdAppFromWalletAddress: queryParameter['fromAddress'],thirdAppToWalletAddress: queryParameter['toAddress'],)));
          }, (TLDError error){
            Fluttertoast.showToast(msg: error.msg);
          });
        }
      }

    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TLDPurseSideslipView(
        didClickCallBack: (int index) {
          Navigator.pop(context);
          if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TLDPaymentChooseWalletPage()));
          } else if (index == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TLDIntegrationDescPage()));
          } else if (index == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TLDAboutUsPage()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TLDUserFeedBackPage()));
          }else {
            // TLDUserAgreementPage
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TLDUserAgreementPage()));
          }
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Color.fromARGB(255, 153, 153, 153),
        iconSize: 26,
        onTap: (index) => _getPage(index),
      ),
      body: Builder(builder: (BuildContext context) {
        return NotificationListener<TLDMoreBtnClickNotification>(
          onNotification: (TLDMoreBtnClickNotification notifcation) {
            Scaffold.of(context).openDrawer();
            return true;
          },
          child: PageView.builder(
            itemBuilder: (BuildContext context, int index) {
              return pages[index];
            },
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            onPageChanged: (int index) {

              setState(() {
                currentIndex = index;
              });
              eventBus.fire(TLDBottomTabbarClickEvent(index));
              if (index == 0){
                  eventBus.fire(TLDRefreshFirstPageEvent());
              }else if(index == 2){
                  eventBus.fire(TLDRefreshMessageListEvent(3));
              }
            },
          ),
        );
      }),
    );
  }

  void _getPage(int index) {
    setState(() {
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
  }

     @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: {
      }// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed:{
      }
        break;
      case AppLifecycleState.paused:{
      } // 应用程序不可见，后台
        break;
      default : {
      }
        break;
    }
  }

}
