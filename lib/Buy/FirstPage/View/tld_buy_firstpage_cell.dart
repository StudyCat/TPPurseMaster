import 'package:dragon_sword_purse/Buy/FirstPage/Model/tld_buy_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_buy_cell_bottom.dart';
import 'package:dragon_sword_purse/CommonWidget/ltd_sale_buy_cell_header.dart';

class TLDBuyFirstPageCell extends StatefulWidget {
  TLDBuyFirstPageCell({Key key,this.didClickBuyBtnCallBack,this.model}) : super(key: key);

  final TLDBuyListInfoModel model;

  final didClickBuyBtnCallBack;

  @override
  _TLDBuyFirstPageCellState createState() => _TLDBuyFirstPageCellState();
}

class _TLDBuyFirstPageCellState extends State<TLDBuyFirstPageCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; 
    return Container(
       padding: EdgeInsets.only(left : 15 , top : 5 ,right: 15),
       width: screenSize.width - 30,  
       child: ClipRRect(
         borderRadius : BorderRadius.all(Radius.circular(4)),
         child : Container(
           color: Colors.white,
           width: screenSize.width - 30,
           padding: EdgeInsets.only(top : 10,bottom : 17),
           child: Column(
             children : <Widget>[
               TLDCommonCellHeaderView(title: I18n.of(context).addressLabel,buttonTitle: I18n.of(context).buyBtnTitle,onPressCallBack: widget.didClickBuyBtnCallBack,buttonWidth: 128,buyModel: widget.model,),
               _leftRightItem(context,34, 0, I18n.of(context).paymentTermLabel, '', false,widget.model.payMethodVO.type),
               _leftRightItem(context,22, 0, I18n.of(context).minimumPurchaseAmountLabel, widget.model.max + 'TLD', true,0),
               _leftRightItem(context,22, 0, I18n.of(context).maximumPurchaseAmountLabel, widget.model.maxAmount + 'TLD', true,0),
             ]
           ),
         ),
       ),
    );
  }

  Widget _leftRightItem(BuildContext context, num top , num bottom,String title , String content,bool isTextType,int paymentType) {
  Size screenSize = MediaQuery.of(context).size;
  return Container(
    padding: bottom == 0 ? EdgeInsets.only(top : ScreenUtil().setHeight(top)) :EdgeInsets.only(top : ScreenUtil().setHeight(top),bottom: ScreenUtil().setHeight(bottom)),
    child: Row(
      mainAxisAlignment : MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding : EdgeInsets.only( left :ScreenUtil().setWidth(20)),
          child: Text(title,style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153))),
        ),
        Container(
          padding : EdgeInsets.only( right :ScreenUtil().setWidth(20)),
          alignment: Alignment.centerRight,
          child: isTextType ? Text(content,style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),maxLines: 1,) : Icon(IconData(_getIconInt(paymentType),fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),)
        ),
      ],
    ),
  );
}}

int _getIconInt(int paymentType){
  if (paymentType == 1){
    return 0xe679;
  }else if (paymentType == 2){
    return 0xe61d;
  }else if (paymentType == 3){
    return 0xe630;
  }else{
    return 0xe65e;
  }
}