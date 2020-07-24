import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_profit_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceProfitListCell extends StatefulWidget {
  TLDAcceptanceProfitListCell({Key key,this.profitListModel}) : super(key: key);

  final TLDAcceptanceProfitListModel profitListModel;

  @override
  _TLDAcceptanceProfitListCellState createState() => _TLDAcceptanceProfitListCellState();
}

class _TLDAcceptanceProfitListCellState extends State<TLDAcceptanceProfitListCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top : ScreenUtil().setHeight(2)),
       child: Container(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20),left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('票据ID：${widget.profitListModel.billId}',style:TextStyle(fontSize : ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153))),
                _getProfitRowWidget(),
                Padding(
                  padding:  EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                  child: _getDateWidget(),
                  )
              ],
            ),
          ),
    );
  }

  Widget _getProfitRowWidget(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children : <InlineSpan>[
                WidgetSpan(
                  child : widget.profitListModel.billIcon != null ? CachedNetworkImage(imageUrl:widget.profitListModel.billIcon,width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32),) : Container(width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32)),
                ),
                TextSpan(
                  text : '  今日收益：${widget.profitListModel.profitTldCount}TLD',
                  style : TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 102, 102, 102))
                )
              ]
            ),
          ),
          Text('${widget.profitListModel.billCount}份',style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 57, 57, 57))),
        ],
      ),
      );
  }

  Widget _getDateWidget(){
    return Container(
      width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      child: Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.profitListModel.createTime), [yyyy,'-',hh,'-',mm,' ',hh,':',nn]),style:TextStyle(fontSize : ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,),
    );
  }

}