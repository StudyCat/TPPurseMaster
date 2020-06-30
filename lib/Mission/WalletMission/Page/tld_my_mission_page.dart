import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_mission_hall_buy_action_sheet.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_mission_hall_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDMyMissionPage extends StatefulWidget {
  TLDMyMissionPage({Key key}) : super(key: key);

  @override
  _TLDMyMissionPageState createState() => _TLDMyMissionPageState();
}

class _TLDMyMissionPageState extends State<TLDMyMissionPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
      return TLDMissionHallCell(didClickBuyBtnCallBack: (){
         showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return TLDMissionHallBuyActionSheet(            
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