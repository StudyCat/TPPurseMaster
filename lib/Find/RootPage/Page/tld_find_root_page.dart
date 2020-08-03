import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_login_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_acceptance_sign_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/TabbarPage/Page/tld_acceptance_tabbar_page.dart';
import 'package:dragon_sword_purse/Find/Rank/Page/tld_rank_tab_page.dart';
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
import 'package:fluttertoast/fluttertoast.dart';

class TLDFindRootPage extends StatefulWidget {
  TLDFindRootPage({Key key}) : super(key: key);

  @override
  _TLDFindRootPageState createState() => _TLDFindRootPageState();
}

class _TLDFindRootPageState extends State<TLDFindRootPage> {
  TLDFindRootModelManager _modelManager;

  List _bannerList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDFindRootModelManager();

    _getBannerList();
  }

  void _getBannerList(){
    _modelManager.getBannerInfo((List bannerList){
    _bannerList = [];
    if(mounted){
      setState(() {
        _bannerList.addAll(bannerList);
      });
    }
    }, (TLDError error){
      Fluttertoast.showToast(msg: error.msg);
    });
  }

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
          return TLDFindRootADBannerView(bannerList: _bannerList,didClickBannerViewCallBack: (TLDBannerModel bannerModel){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDWebPage(title: '',urlStr: bannerModel.bannerHref,)));
          },);
        }else{
          TLDFindRootCellUIModel uiModel = TLDFindRootModelManager.uiModelList[index - 1];
          return TLDFindRootPageCell(uiModel: uiModel,didClickItemCallBack: (String title){
            if (title == '任务'){
              Fluttertoast.showToast(msg: '任务待开发中，敬请期待');
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDNewMissionFirstPage()));
            }else if (title == 'TLD票据'){
              String acceptanceToken = TLDDataManager.instance.acceptanceToken;
              if (acceptanceToken != null){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceTabbarPage()));
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceLoginPage()));
              }
            }else if (title == '排行榜'){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDRankTabPage()));
            }else if (title.length == 0){
              Fluttertoast.showToast(msg: '更多功能，敬请期待');
            }
          },);
        }
      });
  }

}