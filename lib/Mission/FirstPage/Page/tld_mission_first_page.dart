import 'dart:async';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_get_mission_action_sheet.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_mission_first_mission_cell.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_mission_first_wallet_cell.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Page/tld_mission_root_page.dart';
import 'package:dragon_sword_purse/Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:dragon_sword_purse/eventBus/tld_envent_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDMissionFirstPage extends StatefulWidget {
  TLDMissionFirstPage({Key key}) : super(key: key);

  @override
  _TLDMissionFirstPageState createState() => _TLDMissionFirstPageState();
}

class _TLDMissionFirstPageState extends State<TLDMissionFirstPage> {

  StreamSubscription _unreadSubscription;

  bool _haveUnreadMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _haveUnreadMessage = TLDIMManager.instance.unreadMessage.length > 0;

    _registerUnreadMessageEvent();
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
    return  Scaffold(
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'sale_page',
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
            width: ScreenUtil().setWidth(160),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TLDOrderListPage()));
                    }),
                MessageButton(
                  isHaveUnReadMessage: _haveUnreadMessage,
                  didClickCallBack: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TLDMessagePage())),
                )
              ],
            )),
      ),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return TLDMissionFirstMissionCell(didClickGetBtnCallBack: (){
            showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TLDGetMissionActionSheet(            
              );
            });
          },);
        }else{
          return TLDMissionFirstWalletCell(
            didClickItemCallBack: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDMissionRootPage()));
            },
          );
        }
     },
    );
  }

}