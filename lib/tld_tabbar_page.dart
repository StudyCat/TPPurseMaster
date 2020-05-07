import 'package:flutter/cupertino.dart';
import './Buy/FirstPage/Page/tld_buy_page.dart';
import './Exchange/Page/tld_exchange_page.dart';
import './Purse/FirstPage/Page/tld_purse_page.dart';
import './Sale/Page/tld_sale_page.dart';

class TLDTabbarPage extends StatefulWidget {
  TLDTabbarPage({Key key}) : super(key: key);

  @override
  _TLDTabbarPageState createState() => _TLDTabbarPageState();
}

class _TLDTabbarPageState extends State<TLDTabbarPage> {

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(IconData(0xe723,fontFamily: 'appIconFonts')),
    title: Text('钱包',style : TextStyle(fontSize: 10),),),
    BottomNavigationBarItem(icon: Icon(IconData(0xe680,fontFamily: 'appIconFonts')),
    title: Text('购买',style : TextStyle(fontSize: 10,)),),
    BottomNavigationBarItem(icon: Icon(IconData(0xe620,fontFamily: 'appIconFonts')),
    title: Text('售卖',style : TextStyle(fontSize: 10,)),),
    BottomNavigationBarItem(icon: Icon(IconData(0xe60d,fontFamily: 'appIconFonts')),
    title: Text('兑换',style : TextStyle(fontSize: 10,)),),
  ];

  List pages = [
    TLDPursePage(),
    TLDBuyPage(),
    TLDSalePage(),
    TLDExchangePage()
  ];

  int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        activeColor : Color.fromARGB(255, 51, 114, 245),
        inactiveColor: Color.fromARGB(255, 153, 153, 153),
        iconSize: 26,),
      tabBuilder:(context,index) => _getPage(index),
    );
  }

  Widget _getPage(int index){
    currentIndex = index;
    return pages[index];
  }

}