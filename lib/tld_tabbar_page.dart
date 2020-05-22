import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class _TLDTabbarPageState extends State<TLDTabbarPage> {
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
    BottomNavigationBarItem(
      icon: Icon(IconData(0xe60d, fontFamily: 'appIconFonts')),
      title: Text('兑换',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
  ];

  List pages = [TLDPursePage(), TLDBuyPage(), TLDSalePage(), TLDExchangePage()];

  int currentIndex;

  Widget currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentIndex = 0;
    currentPage = pages[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TLDPurseSideslipView(
        didClickCallBack: (int index) {
          Navigator.pop(context);
          if (index == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TLDChoosePaymentPage()));
          } else if (index == 3) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TLDIntegrationDescPage()));
          } else if (index == 5) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TLDAboutUsPage()));
          } else if (index == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TLDUserFeedBackPage()));
          }
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        activeColor: Color.fromARGB(255, 51, 114, 245),
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
            child: currentPage);
      }),
    );
  }

  void _getPage(int index) {
    if (currentIndex != index) {
      setState(() {
        currentIndex = index;
        currentPage = pages[currentIndex];
      });
    }
  }
}
