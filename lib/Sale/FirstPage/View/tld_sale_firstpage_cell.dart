import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/ltd_sale_buy_cell_header.dart';
import 'package:dragon_sword_purse/Sale/FirstPage/Model/tld_sale_list_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



Widget getSaleFirstPageCell(
  String buttonTitle, Function onPressCallBack, BuildContext context,TLDSaleListInfoModel model,Function clickItemCallBack,int type) {
  Size screenSize = MediaQuery.of(context).size;
  bool isHiddeBtn = type == 0 ? false : true;
  return GestureDetector(
    onTap :clickItemCallBack,
    child : Container(
    padding: EdgeInsets.only(left: 15, top: 5, right: 15),
    width: screenSize.width - 30,
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        width: screenSize.width - 30,
        padding: EdgeInsets.only(top: 10, bottom: 17),
        child: Column(children: <Widget>[
          TLDCommonCellHeaderView(title:'订单号',buttonTitle: buttonTitle,onPressCallBack: onPressCallBack,buttonWidth: 166,saleModel: model,isHiddenBtn: isHiddeBtn),
          _leftRightItem(context,34, 0, '收款方式', '', false,model.payMethodVO.type),
          _leftRightItem(context,22, 0, '挂售钱包', model.wallet.name, true,0),
          _leftRightItem(context, 22, 20, '创建时间', getTimeString(model.createTime), true,0),
        ]),
      ),
    ),
  )
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
          width:  ScreenUtil().setWidth(400),
          alignment: Alignment.centerRight,
          child: isTextType ? Text(content,style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 51, 51, 51)),maxLines: 1,) : Icon(IconData(getIconInt(paymentType),fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(28),)
        ),
      ],
    ),
  );
}

int getIconInt(int paymentType){
  if (paymentType == 1){
    return 0xe679;
  }else if (paymentType == 2){
    return 0xe61d;
  }else{
    return 0xe630;
  }
}
