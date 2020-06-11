import 'package:dragon_sword_purse/Sale/DetailSale/Model/tld_detail_sale_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDDetailSaleInfoView extends StatefulWidget {
  TLDDetailSaleInfoView({Key key,this.saleModel}) : super(key: key);

  final TLDDetailSaleModel saleModel;

  @override
  _TLDDetailSaleInfoViewState createState() => _TLDDetailSaleInfoViewState();
}

class _TLDDetailSaleInfoViewState extends State<TLDDetailSaleInfoView> {
  @override
  Widget build(BuildContext context) {
    String currentAmountStr = widget.saleModel != null ? widget.saleModel.currentCount : '0';
    String totalAmountStr = widget.saleModel != null ? widget.saleModel.totalCount : '0';
    String status = '';
    if (widget.saleModel != null){
      if (widget.saleModel.status == 0){
      status = '挂售中';
    }else if(widget.saleModel.status == 1){
      status = '已完成';
    }else{
      status = '已取消';
    }
    }
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
      child: Row(
        mainAxisAlignment : MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getSaleInfoLabel('总量', totalAmountStr + 'TLD'),
          _getSaleInfoLabel('剩余', currentAmountStr + 'TLD'),
          _getSaleInfoLabel('状态', status)
        ],
      ),
    );
  }

  Widget _getSaleInfoLabel(String title,String content){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(title,style: TextStyle(
        fontSize : ScreenUtil().setSp(28),
        color: Theme.of(context).primaryColor
      ),),
      Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
        child: Text(content,style : TextStyle(
          fontSize : ScreenUtil().setSp(28),
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w700
        ),),
      ),
    ],
  );
}

}