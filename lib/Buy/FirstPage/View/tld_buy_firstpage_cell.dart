import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_buy_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_buy_info_label.dart';
import 'tld_buy_cell_bottom.dart';
import 'package:dragon_sword_purse/CommonWidget/ltd_sale_buy_cell_header.dart';

class TLDBuyFirstPageCell extends StatefulWidget {
  TLDBuyFirstPageCell({Key key}) : super(key: key);

  @override
  _TLDBuyFirstPageCellState createState() => _TLDBuyFirstPageCellState();
}

class _TLDBuyFirstPageCellState extends State<TLDBuyFirstPageCell> {
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
                getCommonCellHeader('地址', '购买', (){}, context,128),
                getCellBottomView(),
             ]
           ),
         ),
       ),
    );
  }
}