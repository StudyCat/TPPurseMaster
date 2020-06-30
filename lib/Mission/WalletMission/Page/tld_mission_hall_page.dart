
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_my_mission_body_cell.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_my_mission_header_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/expention_layout.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TLDMissionHallPage extends StatefulWidget {
  TLDMissionHallPage({Key key}) : super(key: key);

  @override
  _TLDMissionHallPageState createState() => _TLDMissionHallPageState();
}

class _TLDMissionHallPageState extends State<TLDMissionHallPage> with AutomaticKeepAliveClientMixin {
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child :SingleChildScrollView(
      child : ExpansionLayoutList(
      expandedHeaderPadding: EdgeInsets.zero,
      children: <ExpansionPanel>[
        ExpansionPanel(headerBuilder: (BuildContext context,bool isOpen){
          return TLDMyMissionHeaderCell(isOpen: _isOpen,didClickItemCallBack: (){
            setState(() {
              _isOpen = ! isOpen;
            });
          },);
        }, body: ListBody(
          children:<Widget>[
            TLDMYMissionBodyCell(),
            TLDMYMissionBodyCell()
          ]
        ),
        isExpanded: _isOpen
        ),
      ],
    )
    ) 
      );
  }

      @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}