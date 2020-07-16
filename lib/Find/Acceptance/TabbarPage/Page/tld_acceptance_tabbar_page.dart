import 'package:dragon_sword_purse/Find/Acceptance/Bill/Page/tld_acceptance_bill_list_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Page/tld_acceptance_invitation_tab_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_acceptance_sign_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Page/tld_acceptance_detail_bill_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceTabbarPage extends StatefulWidget {
  TLDAcceptanceTabbarPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceTabbarPageState createState() => _TLDAcceptanceTabbarPageState();
}

class _TLDAcceptanceTabbarPageState extends State<TLDAcceptanceTabbarPage> {

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_purse.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_purse_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text(
        '票据',
        style: TextStyle(fontSize: 10),
      ),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_buy.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_buy_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('订单',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_message.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_message_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('邀请',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assetss/images/icon_sale.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      icon: Image.asset('assetss/images/icon_sale_unsel.png',width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),fit: BoxFit.cover,),
      title: Text('我的',
          style: TextStyle(
            fontSize: 10,
          )),
    ),
  ];

  List pages = [TLDAcceptanceBillListPage(), Container(), TLDAcceptanceInvitationTabPage(),TLDAcceptanceSignPage()];

  
  int currentIndex;

  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentIndex = 0;

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Color.fromARGB(255, 153, 153, 153),
        iconSize: 26,
        onTap: (index) => _getPage(index),
      ),
      body: Builder(builder: (BuildContext context) {
        return PageView.builder(
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
}