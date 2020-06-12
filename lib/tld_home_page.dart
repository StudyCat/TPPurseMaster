import 'package:dragon_sword_purse/Purse/FirstPage/Page/tld_purse_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dataBase/tld_database_manager.dart';
import 'tld_not_purse_page.dart';
import 'tld_tabbar_page.dart';
import 'Notification/tld_import_create_purse_success_notification.dart';
import 'CommonWidget/tld_data_manager.dart';


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