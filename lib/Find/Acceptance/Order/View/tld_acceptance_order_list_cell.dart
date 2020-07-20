import 'package:dragon_sword_purse/Find/Acceptance/Order/View/tld_acceptance_order_list_cell_header_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAcceptanceOrderListCell extends StatefulWidget {
  TLDAcceptanceOrderListCell({Key key,this.didClickItemCallBack}) : super(key: key);

  final Function didClickItemCallBack;

  @override
  _TLDAcceptanceOrderListCellState createState() => _TLDAcceptanceOrderListCellState();
}

class _TLDAcceptanceOrderListCellState extends State<TLDAcceptanceOrderListCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap :widget.didClickItemCallBack,
    child : Padding(
    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: ScreenUtil().setHeight(10), right: ScreenUtil().setWidth(30)),
    child: Container(
      padding: EdgeInsets.only(bottom : ScreenUtil().setHeight(20)),
      width: MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color : Colors.white
      ),
      child: Column(children: <Widget>[
          TLDAcceptanceOrderListCellHeaderView(),
          _leftRightItem( '票据有效期', '60天'),
          _leftRightItem( '预计承兑收益', '50TLD'),
          _leftRightItem( '票据承兑收益开始时间', '2020.07.17 18:23:45'),
          _leftRightItem('支付钱包', 'huow00238289dh79gd73')
        ]),
      ),
    ),
   );
  }

  Widget _leftRightItem(String title , String content) {
  Size screenSize = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.only(top : ScreenUtil().setHeight(30)),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding : EdgeInsets.only( left :ScreenUtil().setWidth(20)),
          child: Text(title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Container(
          padding : EdgeInsets.only( right :ScreenUtil().setWidth(20)),
          width:  ScreenUtil().setWidth(400),
          alignment: Alignment.centerRight,
          child: Text(content,style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),maxLines: 1,)
        ),
      ],
    ),
  );
}
}