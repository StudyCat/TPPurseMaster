import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_cell_bottom.dart';
import 'package:dragon_sword_purse/CommonWidget/ltd_sale_buy_cell_header.dart';
import 'package:dragon_sword_purse/Mission/WalletMission/View/tld_mission_hall_cell_header_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDMissionHallCell extends StatefulWidget {
  TLDMissionHallCell({Key key,this.didClickBuyBtnCallBack}) : super(key: key);

  final Function didClickBuyBtnCallBack;

  @override
  _TLDMissionHallCellState createState() => _TLDMissionHallCellState();
}

class _TLDMissionHallCellState extends State<TLDMissionHallCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; 
    return Container(
       padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),
       width: screenSize.width - 30,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child : Container(
           color: Colors.white,
           width: screenSize.width - 30,
           padding: EdgeInsets.only(top : 10,bottom : 17),
           child: Column(
             children : <Widget>[
               TLDMissionHallCellHeaderView(didClickBuyBtnCallBack: widget.didClickBuyBtnCallBack,),
              _getCellBottomView(),
             ]
           ),
         ),
       ),
    );
  }

  Widget _getCellBottomView(){
  int iconInt;
  // if (model.payMethodVO.type == 1){
  //   iconInt = 0xe679;
  // }else if(model.payMethodVO.type == 2){
  //   iconInt = 0xe61d;
  // }else{
    iconInt = 0xe630;
  // }
  return Container(
    padding: EdgeInsets.only(top : ScreenUtil().setHeight(18),bottom: ScreenUtil().setHeight(30)),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding : EdgeInsets.only( left :ScreenUtil().setWidth(20)),
          child: Text('收款方式',style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Container(
          padding : EdgeInsets.only( right :ScreenUtil().setWidth(20)),
          width: ScreenUtil().setWidth(200),
          child: Row(
            mainAxisAlignment : MainAxisAlignment.end,
            children: <Widget>[
              Icon(IconData(iconInt,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),),
            ],
          ),
        ),
      ],
    ),
  );
}

}
