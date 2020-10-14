import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_recorder_profit_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDYLBRecorderProfitCell extends StatefulWidget {
  TLDYLBRecorderProfitCell({Key key,this.listModel}) : super(key: key);

  final TLDYLBProfitListModel listModel;

  @override
  _TLDYLBRecorderProfitCellState createState() => _TLDYLBRecorderProfitCellState();
}

class _TLDYLBRecorderProfitCellState extends State<TLDYLBRecorderProfitCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child: Container(
        padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
        decoration : BoxDecoration(
          color : Colors.white,
          borderRadius : BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children : <Widget>[
            _amountWidget(),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
              child: Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.listModel.createTime), [yyyy,'-',mm,'-',dd,' ',hh,':',nn]),textAlign: TextAlign.center,style : TextStyle(color: Color.fromARGB(255, 153, 153, 153),fontSize: ScreenUtil().setSp(24))),
            ),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(14),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
              child: Divider(
                height : ScreenUtil().setHeight(2),
                color : Color.fromARGB(255, 200, 200, 200)
              ),
            ),
          ]
        ),
      ),
      );
  }

  Widget _amountWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children : <Widget>[
        Text(widget.listModel.typeName,textAlign: TextAlign.center,style : TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24))),
        Text('${widget.listModel.tldCount}TLD',textAlign: TextAlign.center,style : TextStyle(color: Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(32))),
      ]
    );
  }

}