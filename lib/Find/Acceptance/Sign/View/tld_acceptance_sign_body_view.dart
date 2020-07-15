import 'package:dragon_sword_purse/Find/Acceptance/Sign/View/tld_acceptance_sign_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceSignBodyView extends StatefulWidget {
  TLDAcceptanceSignBodyView({Key key}) : super(key: key);

  @override
  _TLDAcceptanceSignBodyViewState createState() => _TLDAcceptanceSignBodyViewState();
}

class _TLDAcceptanceSignBodyViewState extends State<TLDAcceptanceSignBodyView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(10),left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
      child:  Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
         decoration: BoxDecoration(
           borderRadius : BorderRadius.all(Radius.circular(4)),
           color : Colors.white
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: <Widget>[
             _getChooseWalletWidget(),
             TLDAcceptanceSignView(),
             Container(
               width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(80),
               child: Text('签到累计获得：1000积分',style:TextStyle(fontSize:ScreenUtil().setSp(20),color: Color.fromARGB(255, 51, 51, 51)),textAlign: TextAlign.start,),
             )
           ],
         ),
      )
    );
  }

  Widget _getChooseWalletWidget(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),right : ScreenUtil().setWidth(20)),
      child: RichText(
              text: TextSpan(
                children : <InlineSpan>[
                  WidgetSpan(child: Icon(IconData(0xe644,fontFamily: 'appIconFonts'),size: ScreenUtil().setHeight(28),color: Color.fromARGB(255, 51, 51, 51),)),
                  TextSpan(text :'   钱包001',style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28)))
                ]
              )
            ),
    );
  }

}