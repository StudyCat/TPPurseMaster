import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_info_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceOrderListCellHeaderView extends StatefulWidget {
  TLDAcceptanceOrderListCellHeaderView({Key key}) : super(key: key);

  @override
  _TLDAcceptanceOrderListCellHeaderViewState createState() => _TLDAcceptanceOrderListCellHeaderViewState();
}

class _TLDAcceptanceOrderListCellHeaderViewState extends State<TLDAcceptanceOrderListCellHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children : <Widget>[
                   Container(
                     padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),top: ScreenUtil().setHeight(36)),
                     width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                     height: ScreenUtil().setHeight(30),
                     child: Text('编号：' + 'dsadasda',style : TextStyle(fontSize : ScreenUtil().setSp(24) ,color : Color.fromARGB(255, 153, 153, 153)),maxLines: 1,overflow: TextOverflow.fade,textAlign: TextAlign.start,softWrap: false,),
                   ),
               Container(
                 padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     _getInfoLabel('票据级别','1级',null),
                     _getInfoLabel('单价', '200TLD',null),
                     _getInfoLabel('分数', '2份',null),
                     _getInfoLabel('总价', '400TLD',null),
                     _getInfoLabel('订单收益', '收益中', Colors.lightGreen)
                   ],
                 ),)]
             );
  }
  
  Widget _getInfoLabel(String title,String content,Color contentColor){
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(title,style: TextStyle(
        fontSize : ScreenUtil().setSp(28),
        color: Color.fromARGB(255, 51, 51, 51)
      ),),
      Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
        child: Text(content,style : TextStyle(
          fontSize : ScreenUtil().setSp(28),
          color: contentColor != null ? contentColor : Color.fromARGB(255, 57, 57, 57),
          fontWeight: FontWeight.bold
        ),),
      ),
    ],
  );
  }
  
}