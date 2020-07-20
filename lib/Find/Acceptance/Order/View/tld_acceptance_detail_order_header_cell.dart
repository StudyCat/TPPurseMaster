import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/Model/tld_acceptance_detail_order_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceDetailOrderHeaderCell extends StatefulWidget {
  TLDAcceptanceDetailOrderHeaderCell({Key key,this.detailOrderInfoModel}) : super(key: key);

  final TLDAcceptanceDetailOrderInfoModel detailOrderInfoModel;

  @override
  _TLDAcceptanceDetailOrderHeaderCellState createState() => _TLDAcceptanceDetailOrderHeaderCellState();
}

class _TLDAcceptanceDetailOrderHeaderCellState extends State<TLDAcceptanceDetailOrderHeaderCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(168), ScreenUtil().setWidth(30), ScreenUtil().setHeight(40)),
        child: _getColumnView(context),
        ),
    );
  }

  Widget _getColumnView(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getStatusRowView(context),
        Padding(
          padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
          child: _getSubContentRowView(),
          )
      ],
    );
  }

  Widget _getSubContentRowView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(widget.detailOrderInfoModel != null ?'票据有效期${widget.detailOrderInfoModel.billExpireDayCount}天' : '',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).hintColor),),
      ],
    );
  }

  Widget _getStatusRowView(BuildContext context){
    TLDOrderStatusInfoModel orderStatusInfoModel = widget.detailOrderInfoModel != null ? TLDDataManager.accptanceOrderListStatusMap[widget.detailOrderInfoModel.acptOrderStatus] : null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(orderStatusInfoModel != null ? orderStatusInfoModel.orderStatusName : '',style :TextStyle(fontSize : ScreenUtil().setSp(44),color: Theme.of(context).hintColor)),
      ],
    );
  }

   

}