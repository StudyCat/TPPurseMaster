import 'package:dragon_sword_purse/Buy/FirstPage/View/tld_buy_info_label.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceOrderListCellHeaderView extends StatefulWidget {
  TLDAcceptanceOrderListCellHeaderView({Key key,this.orderListModel}) : super(key: key);

  final TLDApptanceOrderListModel orderListModel;

  @override
  _TLDAcceptanceOrderListCellHeaderViewState createState() => _TLDAcceptanceOrderListCellHeaderViewState();
}

class _TLDAcceptanceOrderListCellHeaderViewState extends State<TLDAcceptanceOrderListCellHeaderView> {
  @override
  Widget build(BuildContext context) {
    TLDOrderStatusInfoModel orderStatusInfoModel = TLDDataManager.accptanceOrderListStatusMap[widget.orderListModel.acptOrderStatus];
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
                     _getInfoLabel('票据级别','${widget.orderListModel.billLevel}级',null),
                     _getInfoLabel('单价', '${widget.orderListModel.billPrice}TLD',null),
                     _getInfoLabel('分数', '${widget.orderListModel.billCount}份',null),
                     _getInfoLabel('总价', '${widget.orderListModel.totalPrice}TLD',null),
                     _getInfoLabel('订单收益', orderStatusInfoModel.orderStatusName, orderStatusInfoModel.orderStatusColor)
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