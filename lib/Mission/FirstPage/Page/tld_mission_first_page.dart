import 'dart:async';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Message/Page/tld_message_page.dart';
import 'package:dragon_sword_purse/Mission/FirstPage/Model/tld_mission_first_model_manager.dart';
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

class _TLDMissionFirstPageState extends State<TLDMissionFirstPage> with AutomaticKeepAliveClientMixin {


  TLDMissionFirstModelManager _modelManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDMissionFirstModelManager();
  }

  void _getMission(TLDGetTaskPramaterModel pramaterModel){
    _modelManager.getMission(pramaterModel, (){

    }, (TLDError error){

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
          return TLDMissionFirstMissionCell(didClickGetBtnCallBack: (){
            showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TLDGetMissionActionSheet(
                didClickSureGetBtnCallBack: (TLDGetTaskPramaterModel pramaterModel){
                  this._getMission(pramaterModel);
                },            
              );
            });
          },);
     },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}