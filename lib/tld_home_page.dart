import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_alert_view.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Page/tld_purse_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dataBase/tld_database_manager.dart';
import 'tld_not_purse_page.dart';
import 'tld_tabbar_page.dart';
import 'Notification/tld_import_create_purse_success_notification.dart';
import 'CommonWidget/tld_data_manager.dart';
import 'main.dart';


class TLDHomePage extends StatefulWidget {
  TLDHomePage({Key key}) : super(key: key);

  @override
  _TLDHomePageState createState() => _TLDHomePageState();
}

class _TLDHomePageState extends State<TLDHomePage> {

  TLDDataBaseManager _manager;

  bool isHavePurse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _manager = TLDDataBaseManager();


    isHavePurse = false;

     _searchAllPurse();

    JPush jPush = JPush();
    if (Platform.isAndroid){
      jPush.isNotificationEnabled().then((isOpen){
      if (!isOpen){
        Future.delayed(
      Duration.zero,
        (){
          showDialog(context: context,builder:(context){
            return TLDAlertView(title : '温馨提示',alertString:'未开启接收推送通知的权限，是否去开启？',type: TLDAlertViewType.normal,didClickSureBtn: (){
              openAppSettings();
            },);
          });
        }
    );
      }  
    });
    }else{
      
    }

  }

  void _searchAllPurse()async{
    await _manager.openDataBase();
     List allPurse = await _manager.searchAllWallet();
    await _manager.closeDataBase();
    allPurse == null ? TLDDataManager.instance.purseList = [] : TLDDataManager.instance.purseList = List.from(allPurse);

      if(allPurse != null && allPurse.length > 0){
        setState(() {
          isHavePurse = true;
        });
      }
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