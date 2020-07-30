import 'dart:async';
import 'dart:io';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dataBase/tld_database_manager.dart';
import 'tld_not_purse_page.dart';
import 'tld_tabbar_page.dart';
import 'CommonWidget/tld_data_manager.dart';



class TLDHomePage extends StatefulWidget {
  TLDHomePage({Key key}) : super(key: key);

  @override
  _TLDHomePageState createState() => _TLDHomePageState();
}

class _TLDHomePageState extends State<TLDHomePage> {

  TLDDataBaseManager _manager;

  bool isHavePurse;

  JPush jPush;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TLDDataBaseManager();


    isHavePurse = false;

     _searchAllPurse();

    _openPermmision();
    // jPush = JPush();
    // if (Platform.isAndroid){
    //   jPush.isNotificationEnabled().then((isOpen){
    //   if (!isOpen){
    //     Future.delayed(
    //   Duration.zero,
    //     (){
    //       showDialog(context: context,builder:(context){
    //         return TLDAlertView(title : '温馨提示',alertString:'未开启接收推送通知的权限，是否去开启？',type: TLDAlertViewType.normal,didClickSureBtn: (){
    //           openAppSettings().then((value) => null);
    //         },);
    //       });
    //     }
    // );
    //   }  
    // });
    // }else{
      
    // }

    _checkVersion();
  }

  void _openPermmision() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.notification
      ].request();
    print(statuses[Permission.location]);
  }

  void _checkVersion(){
    TLDBaseRequest request = TLDBaseRequest({},'common/tldVersionUpdate');
    request.postNetRequest((value) async{
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      if (version != value['tldVersion']) {
        showDialog(context: context,builder: (context){
        return TLDAlertView(title: '版本更新',alertString: value['updateDesc'],sureTitle:  '更新',didClickSureBtn: (){
          _downloadNewApk(value['apkUrl']);
        },);
      });
      }
    }, (TLDError error){

    });
  }

  _downloadNewApk(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  void _searchAllPurse()async{
    await _manager.openDataBase();
     List allPurse = await _manager.searchAllWallet();
    await _manager.closeDataBase();
    allPurse == null ? TLDDataManager.instance.purseList = [] : TLDDataManager.instance.purseList = List.from(allPurse);

      if(allPurse != null && allPurse.length > 0){
        if (mounted){
        setState(() {
          isHavePurse = true;
        });
        }
      }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);

    if(isHavePurse == false){
      return TLDNotPurseHomePage();
    }else{
       return TLDTabbarPage(); 
    }
  }
}