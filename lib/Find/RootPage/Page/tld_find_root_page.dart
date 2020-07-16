import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_login_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_acceptance_sign_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/TabbarPage/Page/tld_acceptance_tabbar_page.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_ad_banner_view.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_page_cell.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_first_page.dart';
import 'package:dragon_sword_purse/Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDFindRootPage extends StatefulWidget {
  TLDFindRootPage({Key key}) : super(key: key);

  @override
  _TLDFindRootPageState createState() => _TLDFindRootPageState();
}

class _TLDFindRootPageState extends State<TLDFindRootPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'find_root_page',
        transitionBetweenRoutes: false,
        middle: Text('发现',),
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
            MessageButton(
              didClickCallBack: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TLDMessagePage()));
                },
            )
          ],
        )
        ),
      ),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: TLDFindRootModelManager.uiModelList.length + 1,
      itemBuilder: (context,index){
        if (index == 0){
          return TLDFindRootADBannerView();
        }else{
          TLDFindRootCellUIModel uiModel = TLDFindRootModelManager.uiModelList[index - 1];
          return TLDFindRootPageCell(uiModel: uiModel,didClickItemCallBack: (String title){
            if (title == '任务'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDNewMissionFirstPage()));
            }else if (title == '承兑'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceTabbarPage()));
            }
          },);
        }
      });
  }

}