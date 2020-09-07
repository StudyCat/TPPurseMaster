import 'package:dragon_sword_purse/Find/RedEnvelope/Page/tld_detail_red_envelope_page.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_send_red_envelope_inpute_view.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TLDSendRedEnvelopePage extends StatefulWidget {
  TLDSendRedEnvelopePage({Key key}) : super(key: key);

  @override
  _TLDSendRedEnvelopePageState createState() => _TLDSendRedEnvelopePageState();
}

class _TLDSendRedEnvelopePageState extends State<TLDSendRedEnvelopePage> {

  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'send_red_envelope_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).promotionRedEnvelope,
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading,child: _getBodyWidget(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return Column(
      children : <Widget>[
        TLDSendRedEnvelopeInputeView(),
        Padding(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(100),
          ),
          child: Container(
            width : ScreenUtil().setWidth(360),
            height : ScreenUtil().setHeight(96),
            child :CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(I18n.of(context).createRedEnvelope,style : TextStyle(
                fontSize : ScreenUtil().setSp(30),
                color :Colors.white
              )),
              color: Color.fromARGB(255, 210, 49, 67),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailRedEnvelopePage()));
              }),
          )
        )
      ] 
    );
  }

}