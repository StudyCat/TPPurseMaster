import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/3rdPartWeb/Page/tld_3rdpart_web_page.dart';
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
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class TLDFindRootPage extends StatefulWidget {
  TLDFindRootPage({Key key}) : super(key: key);

  @override
  _TLDFindRootPageState createState() => _TLDFindRootPageState();
}

class _TLDFindRootPageState extends State<TLDFindRootPage> {
  TLDFindRootModelManager _modelManager;

  List _bannerList = [];

  List _iconDataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDFindRootModelManager();
    
    _iconDataSource =  TLDFindRootModelManager.uiModelList;

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
      itemCount: _iconDataSource.length + 1,
      itemBuilder: (context,index){
        if (index == 0){
          return TLDFindRootADBannerView(bannerList: _bannerList,didClickBannerViewCallBack: (TLDBannerModel bannerModel){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDWebPage(title: '',urlStr: bannerModel.bannerHref,)));
          },);
        }else{
          TLDFindRootCellUIModel uiModel = _iconDataSource[index - 1];
          return TLDFindRootPageCell(uiModel: uiModel,didClickItemCallBack: (TLDFindRootCellUIItemModel itemModel){
            if (itemModel.title == '任务' && itemModel.url.length == 0){
              Fluttertoast.showToast(msg: '任务待开发中，敬请期待');
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDNewMissionFirstPage()));
            }else if (itemModel.title == 'TLD票据' && itemModel.url.length == 0){
              String acceptanceToken = TLDDataManager.instance.acceptanceToken;
              if (acceptanceToken != null){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceTabbarPage()));
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceLoginPage()));
              }
            }else if (itemModel.title == '排行榜' && itemModel.url.length == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDRankTabPage()));
            }else if (itemModel.title.length == 0 && itemModel.url.length == 0){
              _scanPhoto();
            }else if (itemModel.url.length > 0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLD3rdPartWebPage(urlStr: itemModel.url,)));
            }
          },);
        }
      });
  }

     Future _scanPhoto() async {
    var status = await Permission.camera.status;
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted ||
        status == PermissionStatus.undetermined) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      ].request();
      return;
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TLDScanQrCodePage(
                  scanCallBack: (String result) {
                    _modelManager.get3rdWebInfo(result,
                        (TLD3rdWebInfoModel infoModel) {
                          bool isHaveSameUrl = false;
                          TLDFindRootCellUIModel findRootCellUIModel = _iconDataSource.first;
                          for (TLDFindRootCellUIItemModel item in findRootCellUIModel.items) {
                            if (item.url == infoModel.iconUrl){
                              isHaveSameUrl = true;
                              break;
                            }
                          }
                          if (isHaveSameUrl){
                            Fluttertoast.showToast(msg: '已有相同应用');
                          }else{
                            Fluttertoast.showToast(msg: '添加第三方应用成功');
                            TLDFindRootCellUIItemModel uiItemModel = TLDFindRootCellUIItemModel(title: infoModel.name,iconUrl: infoModel.iconUrl,url: infoModel.url);
                            setState(() {
                              findRootCellUIModel.items.insert(findRootCellUIModel.items.length - 1,uiItemModel);
                            });
                          }
                    }, (TLDError error) {
                      Fluttertoast.showToast(
                          msg: error.msg,
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1);
                    });
                  },
                )));
  }



}