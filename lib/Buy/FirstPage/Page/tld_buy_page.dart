import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import '../View/tld_buy_search_field.dart';
import '../View/tld_buy_firstpage_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Notification/tld_more_btn_click_notification.dart';
import '../../../Order/Page/tld_order_list_page.dart';
import '../View/tld_buy_action_sheet.dart';

class TLDBuyPage extends StatefulWidget {
  TLDBuyPage({Key key}) : super(key: key);

  @override
  _TLDBuyPageState createState() => _TLDBuyPageState();
}

class _TLDBuyPageState extends State<TLDBuyPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _getBodyWidget(size.width),
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
            MessageButton()
          ],
        )
        ),
      ),
    );
  }

  Widget _getBodyWidget(double screenWidth){
    return Container(
      width: screenWidth,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TLDBuySearchField(),
        Expanded(
          child: ListView.builder(
          itemCount: 11,
          itemBuilder: (BuildContext context, int index) {
          return TLDBuyFirstPageCell(didClickBuyBtnCallBack: (){
            showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TLDBuyActionSheet();
            });
          },);
         },
        ), 
        ),
      ],
    ),
    );
  }
}
