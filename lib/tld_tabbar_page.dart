import 'dart:async';
import 'dart:convert';

import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Page/tld_payment_choose_wallet.dart';
import 'package:dragon_sword_purse/Drawer/UserAgreement/Page/tld_user_agreement_page.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Page/tld_tab_sale_page.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import './Buy/FirstPage/Page/tld_buy_page.dart';
import './Exchange/FirstPage/Page/tld_exchange_page.dart';
import './Purse/FirstPage/Page/tld_purse_page.dart';
import './Sale/FirstPage/Page/tld_sale_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Purse/FirstPage/View/purse_firstpage_sideslip.dart';
import 'Drawer/PaymentTerm/Page/tld_choose_payment_page.dart';
import 'Notification/tld_more_btn_click_notification.dart';
import 'Drawer/IntegrationDesc/Page/tld_integration_desc_page.dart';
import 'Drawer/AboutUs/Page/tld_about_us_page.dart';
import 'Drawer/UserFeedback/Page/tld_user_feedback_page.dart';

class TLDTabbarPage extends StatefulWidget {
  TLDTabbarPage({Key key}) : super(key: key);

  @override
  _TLDTabbarPageState createState() => _TLDTabbarPageState();
}

class _TLDTabbarPageState extends State<TLDTabbarPage> with WidgetsBindingObserver {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(IconData(0xe723, fontFamily: 'appIconFonts')),
      title: Text(
        '钱包',
        style: TextStyle(fontSize: 10),
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(IconData(0xe680, fontFamily: 'appIconFonts')),
      title: Text('购买',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      icon: Icon(IconData(0xe620, fontFamily: 'appIconFonts')),
      title: Text('售卖',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
  ];

  List pages = [TLDPursePage(), TLDBuyPage(), TLDTabSalePage()];

  int currentIndex;

  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    currentIndex = 0;
    _pageController = PageController();
    
    List purseList = TLDDataManager.instance.purseList;
      List addressList = [];
      for (TLDWallet item in purseList) {
        addressList.add(item.address);
      }
     String addressListJson = jsonEncode(addressList);
    TLDIMManager manager = TLDIMManager.instance;
    manager.connectClient();
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
        TLDIMManager.instance.isInBackState = true;
      }// 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed:{
        TLDIMManager.instance.isInBackState = false;
        TLDIMManager.instance.connectClient();
      }
        break;
      case AppLifecycleState.paused:{
        TLDIMManager.instance.isInBackState = true;
      } // 应用程序不可见，后台
        break;
      default : {
        TLDIMManager.instance.isInBackState = true;
      }
        break;
    }
  }

}
