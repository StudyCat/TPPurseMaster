import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_profit_spill_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceProfitSpillUnopenCell extends StatefulWidget {
  TLDAcceptanceProfitSpillUnopenCell({Key key,this.didClickItemCallBack,this.listModel}) : super(key: key);

  final Function didClickItemCallBack;

  final TLDAcceptanceProfitSpillListModel listModel;

  @override
  _TLDAcceptanceProfitSpillUnopenCellState createState() => _TLDAcceptanceProfitSpillUnopenCellState();
}

class _TLDAcceptanceProfitSpillUnopenCellState extends State<TLDAcceptanceProfitSpillUnopenCell> {
   @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: widget.didClickItemCallBack,
     child:  Padding(
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
    return Padding(padding: EdgeInsets.only(left : 0,right:0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getTitleWidget(),
         Icon(IconData(0xe60b,fontFamily : 'appIconFonts'),color: Color.fromARGB(255, 153, 153, 153),size: ScreenUtil().setSp(28),),
      ],
    ),);
  }

  Widget _getTitleWidget(){
    return Container(
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:<Widget>[
         Container(
            width : ScreenUtil().setWidth(60),
            height: ScreenUtil().setHeight(40),
            decoration: BoxDecoration(
              border : Border.all(color: widget.listModel.overflowType == 1 ? Color.fromARGB(255, 240, 131, 30) : Color.fromARGB(255, 65, 117, 5),width:0.5),
              borderRadius : BorderRadius.all(Radius.circular(4)),
              color :widget.listModel.overflowType == 1 ? Color.fromARGB(255, 244, 183, 83) : Color.fromARGB(255, 126, 211, 33)
            ),
            child: Center(
              child : Text(widget.listModel.overflowType == 1 ? '静态' : '推广',style:TextStyle(fontSize:ScreenUtil().setSp(24),color:widget.listModel.overflowType == 1 ? Color.fromARGB(255, 144, 76, 12) : Color.fromARGB(255, 65, 117, 5)))
            ),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
          child :  Text('${widget.listModel.billLevel}级TLD票据：溢出${widget.listModel.overflowCount}TLD',style: TextStyle(fontSize : ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51)),),
          )
      ]
    ),
    );
  }
}