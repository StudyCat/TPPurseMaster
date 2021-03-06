import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/3rdPartWeb/Page/tld_3rdpart_web_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_change_user_info_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_person_center_page.dart';
import 'package:dragon_sword_purse/Find/AAA/Page/tld_aaa_tabbar_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Login/Page/tld_acceptance_login_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Sign/Page/tld_acceptance_sign_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/TabbarPage/Page/tld_acceptance_tabbar_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Page/tld_acceptance_withdraw_tab_page.dart';
import 'package:dragon_sword_purse/Find/Promotion/tld_promotion_page.dart';
import 'package:dragon_sword_purse/Find/Rank/Page/tld_rank_tab_page.dart';
import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/Page/tld_recieve_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Page/tld_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Page/tld_send_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_red_envelop_cell.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/Page/tld_bill_Repaying_page.dart';
import 'package:dragon_sword_purse/Find/RootPage/Page/tld_game_page.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_ad_banner_view.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_find_root_page_cell.dart';
import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_tab_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/NewMission/FirstPage/Page/tld_new_mission_first_page.dart';
import 'package:dragon_sword_purse/Notification/tld_more_btn_click_notification.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_list_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import 'package:dragon_sword_purse/ScanQRCode/tld_scan_qrcode_page.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TLDFindRootPage extends StatefulWidget {
  TLDFindRootPage({Key key}) : super(key: key);

  @override
  _TLDFindRootPageState createState() => _TLDFindRootPageState();
}

class _TLDFindRootPageState extends State<TLDFindRootPage> {
  TLDFindRootModelManager _modelManager;

  List _bannerList = [];

  List _iconDataSource = [];

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDFindRootModelManager();
    
    _iconDataSource =  TLDFindRootModelManager.uiModelList;

    _getBannerList();

    _get3rdWebList();

    _getPlatformWeb();
  }

  void _get3rdWebList() async {
    List webList = await TLDDataManager.instance.get3rdPartWebList();

    _addWebAppInPage(webList);
  }


  void _addWebAppInPage(List webList){
    TLDFindRootCellUIModel findRootCellUIModel = _iconDataSource.first;
    List newWebList = [];
    for (TLD3rdWebInfoModel item in webList) {
        TLDFindRootCellUIItemModel uiItemModel = TLDFindRootCellUIItemModel(title: item.name,iconUrl: item.iconUrl,url: item.url,isNeedHideNavigation: item.isNeedHideNavigation,appType: item.appType);
        if (uiItemModel.url == 'AAA'){
           findRootCellUIModel.items.insert(2, uiItemModel);
        }else if (uiItemModel.url == 'TLD_YLB'){
          findRootCellUIModel.items.insert(2, uiItemModel);
        }else if (uiItemModel.url == 'TLD_BILL'){
          findRootCellUIModel.items.insert(0, uiItemModel);
        }else{
          newWebList.add(uiItemModel);
        }
    }

    setState(() {
      findRootCellUIModel.items.insertAll(findRootCellUIModel.items.length - 1, newWebList);
    });
  }

  void _isOpenMission(){
     setState(() {
      _isLoading = true;
    });
    _modelManager.isOpenMission((bool isOpen){
       if (mounted){}
      setState(() {
      _isLoading = false;
    });
    if (isOpen){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDNewMissionFirstPage()));
    }else{
      Fluttertoast.showToast(msg: I18n.of(context).missionNotOpenAlertDesc);
    }
    }, (TLDError error){
       if (mounted){}
      setState(() {
      _isLoading = false;
    });
    Fluttertoast.showToast(msg: error.msg);
    });
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

  void _getPlatformWeb(){
    _modelManager.getPlatform3rdWeb((List platformApps){
      _addWebAppInPage(platformApps);
    }, (error) {

    });
  }

  void _isHaveAcceptanceUser(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.haveAcceptanceUser((bool needBinding){
      if (mounted){}
      setState(() {
      _isLoading = false;
    });
      if (needBinding == false){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  TLDAcceptanceTabbarPage()
        ));
      }else{
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  TLDEchangeChooseWalletPage(type: TLDEchangeChooseWalletPageType.binding,)
        ));
      }
    }, (TLDError error){
      if (mounted){
        setState(() {
        _isLoading = false;
        });
      }
      if (error.code == -1000){
        showDialog(context: context,builder: (context){
          return TLDAlertView(title : '温馨提示',type: TLDAlertViewType.normal,alertString :error.msg,didClickSureBtn :(){

          });
        });
      }else if (error.code == -1001){
        Navigator.push(context, MaterialPageRoute(builder : (context){
          return TLDBillRepayingPage();
        })).then((value){
            _iconDataSource =  TLDFindRootModelManager.uiModelList;

            _get3rdWebList();

            _getPlatformWeb();
        });
      }else{
        Fluttertoast.showToast(msg: error.msg);
      }
    });
  }

  void _isHaveAAAUserInfo(){
     setState(() {
      _isLoading = true;
    });
    _modelManager.haveAAAUserInfo((bool isHave){
      if (mounted){}
      setState(() {
      _isLoading = false;
    });
      if (isHave){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  TLDAAATabbarPage()
        ));
      }else{
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  TLDAAAChangeUserInfoPage(isFirstLogin: true,)
        ));
      }
    }, (TLDError error){
      if (mounted){
        setState(() {
      _isLoading = false;
    });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'find_root_page',
        transitionBetweenRoutes: false,
        middle: Text(I18n.of(context).findPageTitle,),
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLD3rdPartWebPage(isNeedHideNavigation: !bannerModel.isNeedNavigation,urlStr: bannerModel.bannerHref,)));
          },);
        }else{
          TLDFindRootCellUIModel uiModel = _iconDataSource[index - 1];
          return TLDFindRootPageCell(uiModel: uiModel,didClickItemCallBack: (TLDFindRootCellUIItemModel itemModel){
            if (itemModel.title == I18n.of(context).missionLabel && itemModel.url.length == 0){
              _isOpenMission();
            }else if (itemModel.title == I18n.of(context).tldRedEnvelope && itemModel.url.length == 0){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDRedEnvelopePage()));
            }else if (itemModel.title == I18n.of(context).recieveRedEnvelope&& itemModel.url.length == 0){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDRecieveRedEnvelopePage()));
            }else if (itemModel.title == I18n.of(context).rankLabel && itemModel.url.length == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDRankTabPage()));
            }else if (itemModel.title == I18n.of(context).game && itemModel.url.length == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDGamePage()));
            }else if (itemModel.title == I18n.of(context).promotion && itemModel.url.length == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDPromotionPage()));
            }else if (itemModel.title.length == 0 && itemModel.url.length == 0){
              _scanPhoto();
            }else if (itemModel.url.length > 0){
              if (itemModel.url == 'AAA'){
                _isHaveAAAUserInfo();
              }else if (itemModel.url == 'CASH'){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  TLDAcceptanceWithdrawPage(),));
              }else if (itemModel.url == 'CASH_LOG'){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  TLDAcceptanceWithdrawTabPage(),));
              }else if (itemModel.url == 'TLD_YLB'){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TLDYLBTabPage()));
              }else if (itemModel.url == 'TLD_BILL'){
                _isHaveAcceptanceUser();
              }else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TLD3rdPartWebPage(urlStr: itemModel.url,isNeedHideNavigation: itemModel.isNeedHideNavigation,)));
              }
            }
          },
          didLongClickItemCallBack: (TLDFindRootCellUIItemModel itemModel){
            if (itemModel.url.length > 0 && itemModel.appType == 0){
              showDialog(context: context,builder : (context){
                return TLDAlertView(
                  title: I18n.of(context).warning,
                  alertString: I18n.of(context).areYouSureToDelete + '${itemModel.title}?',
                  didClickSureBtn: (){
                    setState(() {
                      uiModel.items.remove(itemModel);
                    });
                    _delete3rdPartWebInfo(itemModel);
                  },
                );
              });
            }
          },
          didClickQuestionItem: (){
            Navigator.push(context, MaterialPageRoute(builder : (context) => TLDWebPage(type: TLDWebPageType.playDescUrl,title: '玩法说明',)));
          },
          );
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
                            if (item.url == infoModel.url){
                              isHaveSameUrl = true;
                              break;
                            }
                          }
                          if (isHaveSameUrl){
                            Fluttertoast.showToast(msg: I18n.of(context).haveSameApplicationAlertDesc);
                          }else{
                            Fluttertoast.showToast(msg: I18n.of(context).jointhirdPartyApplictionAlertDesc);
                            TLDFindRootCellUIItemModel uiItemModel = TLDFindRootCellUIItemModel(title: infoModel.name,iconUrl: infoModel.iconUrl,url: infoModel.url,appType: 0,isNeedHideNavigation: infoModel.isNeedHideNavigation);
                            setState(() {
                              findRootCellUIModel.items.insert(findRootCellUIModel.items.length - 1,uiItemModel);
                            });

                            _save3rdPartWebInfo(infoModel);
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

  void _save3rdPartWebInfo(TLD3rdWebInfoModel infoModel) async {
      List webInfoList = TLDDataManager.instance.webList;
      webInfoList.add(infoModel);
      List result = [];
      for (TLD3rdWebInfoModel infoModel  in webInfoList) {
        result.add(infoModel.toJson());
      }
      String jsonStr = jsonEncode(result);
      SharedPreferences pre = await SharedPreferences.getInstance();
      pre.setString('3rdPartWeb', jsonStr);

      _save3rdPartWebInService(infoModel);
  }

  void _delete3rdPartWebInfo(TLDFindRootCellUIItemModel infoModel) async {
     List webInfoList = TLDDataManager.instance.webList;
     TLD3rdWebInfoModel deleteModel;
     for (TLD3rdWebInfoModel item  in webInfoList) {
       if (item.url == infoModel.url){
         deleteModel = item;
         break;
       }
     }
     List result = [];
     webInfoList.remove(deleteModel);
      for (TLD3rdWebInfoModel infoModel  in webInfoList) {
        result.add(infoModel.toJson());
      }
      String jsonStr = jsonEncode(result);
      SharedPreferences pre = await SharedPreferences.getInstance();
      pre.setString('3rdPartWeb', jsonStr);
  }

  void _save3rdPartWebInService(TLD3rdWebInfoModel infoModel){
    _modelManager.save3rdPartWeb(infoModel, (){

    }, (error) {

    });
  }

}