import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Page/tld_payment_manager_page.dart';

class TLDPaymentManagerAddPaymentCell extends StatefulWidget {
  TLDPaymentManagerAddPaymentCell({Key key,this.type,this.didClickItemCallBack}) : super(key: key);

  final TLDPaymentType type;

  final Function didClickItemCallBack;

  @override
  _TLDPaymentManagerAddPaymentCellState createState() => _TLDPaymentManagerAddPaymentCellState();
}

class _TLDPaymentManagerAddPaymentCellState extends State<TLDPaymentManagerAddPaymentCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.didClickItemCallBack,
      child: Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left:ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
       child: Container(
         height : ScreenUtil().setHeight(88),
         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(4)),
           color: Colors.white
         ),
         child : Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Icon(IconData(0xe67e,fontFamily:'appIconFonts'),size: ScreenUtil().setWidth(32),),
             Text(getTitleString(),style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28)),)
           ],
         )
         )
       ),
    );
  }

  String getTitleString(){
     if(widget.type == TLDPaymentType.wechat){
      return '添加微信号';
    }else if(widget.type == TLDPaymentType.alipay){
      return '添加支付宝';
    }else if(widget.type == TLDPaymentType.bank){
      return '添加银行卡';
    }else{
      return '添加自定义支付方式';
    }
  }
}