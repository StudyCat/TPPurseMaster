import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_button.dart';
import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_info_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDMissionHallCellHeaderView extends StatefulWidget {
  TLDMissionHallCellHeaderView({Key key}) : super(key: key);

  @override
  _TLDMissionHallCellHeaderViewState createState() => _TLDMissionHallCellHeaderViewState();
}

class _TLDMissionHallCellHeaderViewState extends State<TLDMissionHallCellHeaderView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
             children : <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Container(
                     padding: EdgeInsets.only(left : 10),
                     width: size.width - 128,
                     height: ScreenUtil().setHeight(30),
                     child: Text('编号：98942930' ,style : TextStyle(fontSize : ScreenUtil().setSp(24) ,color : Color.fromARGB(255, 153, 153, 153)),maxLines: 1,overflow: TextOverflow.fade,textAlign: TextAlign.start,softWrap: false,),
                   ),
                   Offstage(
                     offstage : false,
                     child : picAndTextButton('assetss/images/firspage_buy.png', '购买', (){},128)
                   )
                 ],
               ),
               Container(
                 padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     getBuyInfoLabel('等级', 'L1'),
                     getBuyInfoLabel('总量', '1888TLD'),
                     getBuyInfoLabel('最低购买额度','1888TLD'),
                     getBuyInfoLabel('剩余', '1888TLD'),
                   ],
                 ),)]
             );
  }
}