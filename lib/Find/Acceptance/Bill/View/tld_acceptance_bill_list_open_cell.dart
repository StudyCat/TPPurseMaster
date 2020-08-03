import 'package:dragon_sword_purse/Find/Acceptance/Bill/Model/tld_acceptance_bill_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_bill_dash_line.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAcceptanceBillListOpenCell extends StatefulWidget {
  TLDAcceptanceBillListOpenCell({Key key,this.didClickBuyButtonCallBack,this.didClickCheckButtonCallBack,this.didClickOpenItemCallBack,this.infoListModel}) : super(key: key);

  final Function didClickBuyButtonCallBack;

  final Function(int) didClickCheckButtonCallBack;

  final Function didClickOpenItemCallBack;

  final TLDBillInfoListModel infoListModel;

  @override
  _TLDAcceptanceBillListOpenCellState createState() =>
      _TLDAcceptanceBillListOpenCellState();
}

class _TLDAcceptanceBillListOpenCellState
    extends State<TLDAcceptanceBillListOpenCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: _getHeaderWidget(),
          ),
         Offstage(
           offstage: widget.infoListModel.maxProfitDesc.length == 0,
           child:  Padding(padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: Text(widget.infoListModel.maxProfitDesc,style:TextStyle(
              color : Color.fromARGB(255, 153, 153, 153),
              fontSize : ScreenUtil().setSp(20)
            )),),
         ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(26)),
            child: TLDBillDashLine(),
          ),
         _getOrderInfoColumnView(),
          _getSaleButtonWidget()
        ]),
      ),
    );
  }

  Widget _getOrderInfoColumnView(){
    if(widget.infoListModel.orderList.length > 0){
      return  Column(
      children: _getOrderList()
    );
    }else{
      return Container();
    }
  }

  List<Widget> _getOrderList(){
    List<Widget> result = [];
    int count = widget.infoListModel.orderList.length;
    for (int i = 0; i < count; i++) {
      TLDApptanceOrderListModel listModel = widget.infoListModel.orderList[i];
      result.add(_getOrderInfoRowView(listModel,i));
    }
    return result;
  }

  Widget _getHeaderWidget() {
    return GestureDetector(
      onTap: widget.didClickOpenItemCallBack,
      child: Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(32),bottom : ScreenUtil().setHeight(20)),
        child: Stack(
          children : <Widget>[
           Padding(
            child:  Container(
              width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
              child: Text('${widget.infoListModel.billLevel}级TLD票据：${widget.infoListModel.billPrice}每份（${widget.infoListModel.alreadyBuyCount}/${widget.infoListModel.totalBuyCount}）',style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(32),),textAlign: TextAlign.center),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20)
          ),
          Positioned(right: ScreenUtil().setWidth(20),
            child: Icon(Icons.keyboard_arrow_up,color: Color.fromARGB(255, 153, 153, 153),))
          ]
        ),
    ),
    );
  }

  Widget _getOrderInfoRowView(TLDApptanceOrderListModel orderListModel,int index){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(30),left : ScreenUtil().setWidth(20),right : ScreenUtil().setWidth(20)),
      child: Container(
        width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : <Widget>[
            RichText(
              text: TextSpan(children: <InlineSpan>[
            WidgetSpan(
                child: Icon(
              IconData(0xe670, fontFamily: 'appIconFonts'),
              size: ScreenUtil().setWidth(40),
              color: Theme.of(context).hintColor,
            )),
            TextSpan(
                text: '  订单号：${orderListModel.acptOrderNo}',
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 102, 102),
                    fontSize: ScreenUtil().setSp(28)))
          ])),
          GestureDetector(
            onTap:(){
              widget.didClickCheckButtonCallBack(index);
            },
            child : RichText(
              text: TextSpan(text: '${orderListModel.billCount}份',style: TextStyle(fontSize:ScreenUtil().setSp(28),color:Color.fromARGB(255, 51, 51, 51)),children: <InlineSpan>[
            TextSpan(
                text: '  查看',
                style: TextStyle(
                    color: Theme.of(context).hintColor,
                    fontSize: ScreenUtil().setSp(28)))
          ]))
          )
          ]
        ),
      ),
      );
  }
  
  Widget _getSaleButtonWidget(){
    return Container(
        padding: EdgeInsets.only(top:ScreenUtil().setHeight(26),bottom: ScreenUtil().setHeight(26)),
        width:ScreenUtil().setWidth(188),
        height : ScreenUtil().setHeight(124),
        child:  CupertinoButton(
            onPressed: widget.didClickBuyButtonCallBack,
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(36))),
            padding: EdgeInsets.zero,
            child: Text('购买',style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28))),
            color: Theme.of(context).hintColor,
          ),
    );
  }
}
