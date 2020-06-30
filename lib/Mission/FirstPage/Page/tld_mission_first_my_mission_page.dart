import 'package:dragon_sword_purse/Mission/FirstPage/View/tld_mission_first_my_mission_cell.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/Page/tld_mission_root_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDMissionFirstMyMissionPage extends StatefulWidget {
  TLDMissionFirstMyMissionPage({Key key}) : super(key: key);

  @override
  _TLDMissionFirstMyMissionPageState createState() => _TLDMissionFirstMyMissionPageState();
}

class _TLDMissionFirstMyMissionPageState extends State<TLDMissionFirstMyMissionPage> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
          return TLDMissionFirstMyMissionCell(
            didClickItemCallBack: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDMissionRootPage()));
            },
          );
     },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}