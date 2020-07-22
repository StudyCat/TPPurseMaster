import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TLDAcceptanceInvitationQRCodeView extends StatefulWidget {
  TLDAcceptanceInvitationQRCodeView({Key key,this.qrCode,this.inviteCode}) : super(key: key);

  final String qrCode;

  final String inviteCode;

  @override
  _TLDAcceptanceInvitationQRCodeViewState createState() => _TLDAcceptanceInvitationQRCodeViewState();
}

class _TLDAcceptanceInvitationQRCodeViewState extends State<TLDAcceptanceInvitationQRCodeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(40),right: ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(30)),
       child: Container(
         height : ScreenUtil().setHeight(760),
         width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(140),
         color :Theme.of(context).primaryColor,
         child : Column(
           children : <Widget>[
             Padding(
               padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
               child: Text('我的推广邀请码',style: TextStyle(color:Theme.of(context).hintColor,fontSize: ScreenUtil().setSp(40)),),
             ),
             Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                child: widget.qrCode.length > 0 ? QrImage(data: widget.qrCode,size : ScreenUtil().setWidth(408),backgroundColor: Colors.white,) : Container(width : ScreenUtil().setWidth(408),height: ScreenUtil().setWidth(408),),
            ),
              Padding(
               padding: EdgeInsets.only(top : ScreenUtil().setHeight(24)),
               child: Text('推广码 ${widget.inviteCode}',style: TextStyle(color:Colors.white,fontSize: ScreenUtil().setSp(24)),),
             ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(48)),
                child: Image.asset('assetss/images/tld_icon.png',width: ScreenUtil().setWidth(236),height: ScreenUtil().setHeight(54),alignment: Alignment.center,),
              ),
           ]
         )
       ),
    );
  }
}