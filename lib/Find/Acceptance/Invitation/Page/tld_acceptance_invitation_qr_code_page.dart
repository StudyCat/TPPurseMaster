import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_qr_code_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceInvitationQRCodePage extends StatefulWidget {
  TLDAcceptanceInvitationQRCodePage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceInvitationQRCodePageState createState() => _TLDAcceptanceInvitationQRCodePageState();
}

class _TLDAcceptanceInvitationQRCodePageState extends State<TLDAcceptanceInvitationQRCodePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(20), ScreenUtil().setWidth(30), ScreenUtil().setHeight(20)),
      child: Container(
        decoration: BoxDecoration(
          color : Colors.white,
          borderRadius : BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
          children: <Widget>[
            TLDAcceptanceInvitationQRCodeView(),
            Padding(
              padding: EdgeInsets.only(top : ScreenUtil().setHeight(68)),
              child: Container(
                height : ScreenUtil().setHeight(80),
                width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
                child : CupertinoButton(child: Text('保存图片',style:TextStyle(color:Theme.of(context).hintColor)), padding: EdgeInsets.zero,borderRadius: BorderRadius.all(Radius.circular(4)),color: Theme.of(context).primaryColor,onPressed: (){}) 
              ),
            )
          ],
        ),
      ),
    );
  }
}