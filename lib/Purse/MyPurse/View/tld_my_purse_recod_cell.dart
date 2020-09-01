import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/Purse/MyPurse/Model/tld_my_purse_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_format/date_format.dart';

class TLDMyPurseRecordCell extends StatefulWidget {
  TLDMyPurseRecordCell({Key key,this.transferInfoModel,this.walletAddress}) : super(key: key);

  final TLDPurseTransferInfoModel transferInfoModel;

  final String walletAddress;

  @override
  _TLDMyPurseRecordCellState createState() => _TLDMyPurseRecordCellState();
}

class _TLDMyPurseRecordCellState extends State<TLDMyPurseRecordCell> {

  bool isGetMoney;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    if (widget.transferInfoModel.toWalletAddress == widget.walletAddress){
      isGetMoney = true;
    }else{
      isGetMoney = false;
    }
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(2)),
      child : ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          margin : EdgeInsets.all(0),
          height: ScreenUtil().setHeight(242),
          child: Row(
            children : <Widget>[
              Container(
                width: ScreenUtil().setWidth(8),
                height: ScreenUtil().setHeight(168),
                child: Image.asset(isGetMoney ? 'assetss/images/record_blue.png' :'assetss/images/record_black.png'),
              ),
              Expanded(child: getContentView())
            ],
          ),
        ), 
      )
      );
  }

  Widget getContentView(){
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(20), ScreenUtil().setWidth(20), ScreenUtil().setWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          getAdressView(context,I18n.of(context).sendAddress,widget.transferInfoModel.fromWalletAddress),
          getAdressView(context, I18n.of(context).recieveAddress, widget.transferInfoModel.toWalletAddress),
          getNumLabel(context),
          getOtherInfoView(context),
        ],
      ));
  }

  Widget getAdressView(BuildContext context,String title,String content){
    Size size = MediaQuery.of(context).size;
    bool isMineWallet = false;
    if (content == widget.walletAddress){
      isMineWallet = true;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title,style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),),
        Container(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20)),
          width: size.width - ScreenUtil().setWidth(350),
          child: Text(content,maxLines : 2 , style : TextStyle(fontSize : ScreenUtil().setSp(24),color:isMineWallet ? Color.fromARGB(255, 241, 131, 30): Color.fromARGB(255, 153, 153, 153)),overflow: TextOverflow.ellipsis,),
        ),
      ],
    );
  }

  Widget getNumLabel(BuildContext context){
    Size size = MediaQuery.of(context).size;
    Color textColor = isGetMoney == true ? Color.fromARGB(255, 68, 149, 34) : Color.fromARGB(255, 208, 27, 1);
    String plusOrMinus = isGetMoney == true ? '+' : '-';
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),top: ScreenUtil().setWidth(10)),
      child: Text(plusOrMinus +  widget.transferInfoModel.value + ' TLD',style: TextStyle(fontSize : ScreenUtil().setSp(32),color: textColor),textAlign: TextAlign.right,),
    );
  }

  Widget getOtherInfoView(BuildContext context){
     return Container(
       padding: EdgeInsets.only(
         top : ScreenUtil().setHeight(22),
       ),
       child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.transferInfoModel.createTime),[yyyy,'.',mm,'.',dd,' ',HH,':',nn,':',ss]),style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)),),
        Text(I18n.of(context).serviceChargeLabel + widget.transferInfoModel.chargeValue + ' TLD',maxLines : 1 , style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),overflow: TextOverflow.ellipsis,
        )]
    ),
     );
  }
  
}