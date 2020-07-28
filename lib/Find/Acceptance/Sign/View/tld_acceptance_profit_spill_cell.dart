import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_profit_spill_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceProfitSpillOpenCell extends StatefulWidget {
  TLDAcceptanceProfitSpillOpenCell({Key key,this.didClickwithdrawButtonCallBack,this.listModel}) : super(key: key);

  final Function didClickwithdrawButtonCallBack;

  final TLDAcceptanceProfitSpillListModel listModel;

  @override
  _TLDAcceptanceProfitSpillOpenCellState createState() => _TLDAcceptanceProfitSpillOpenCellState();
}

class _TLDAcceptanceProfitSpillOpenCellState extends State<TLDAcceptanceProfitSpillOpenCell> {
  @override
  Widget build(BuildContext context) {
   return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
       child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
         ),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0, ScreenUtil().setHeight(20)),
        child: SizedBox(
      height: 18,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            child: Container(
              child: _getRowView(),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          Positioned(
            left: -9,
            child: _getCardCircle(),
          ),
          Positioned(
            right: -9,
            child: _getCardCircle(),
          ),
        ],
      ),
    ),
       ),
    );
  }


  Widget _getCardCircle() {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 242, 242, 242),
      ),
    );
  }

   Widget _getRowView(){
    return Padding(padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right:ScreenUtil().setWidth(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('${widget.listModel.billLevel}级TLD票据：溢出${widget.listModel.overflowCount}TLD',style: TextStyle(fontSize : ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51)),),
         Container(
              height : ScreenUtil().setHeight(60),
              width : ScreenUtil().setWidth(140),
              child: CupertinoButton(
                onPressed: widget.didClickwithdrawButtonCallBack,
                padding: EdgeInsets.zero,
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Text('领取',style: TextStyle(color : Theme.of(context).hintColor,fontSize:ScreenUtil().setSp(28)),),
              ),
          ),
      ],
    ),);
  }
}