import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import '../Buy/FirstPage/View/tld_buy_button.dart';
import '../Buy/FirstPage/View/tld_buy_info_label.dart';

Widget getCommonCellHeader(String title,String buttonTitle ,Function onPressCallBack,BuildContext context,double buttonWidth){
  Size screenSize = MediaQuery.of(context).size;
  return Column(
             children : <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Container(
                     padding: EdgeInsets.only(left : 10),
                     child: Text(title +'：fwefwefewfwefwef',style : TextStyle(fontSize : ScreenUtil().setSp(24) ,color : Color.fromARGB(255, 153, 153, 153))),
                   ),
                   picAndTextButton('assetss/images/firspage_buy.png', buttonTitle, onPressCallBack,buttonWidth)
                 ],
               ),
               Container(
                 padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     getBuyInfoLabel('总量', '1839TLD'),
                     getBuyInfoLabel('限额', '1839TLD'),
                     getBuyInfoLabel('剩余', '1839TLD'),
                   ],
                 ),)]
             );
}