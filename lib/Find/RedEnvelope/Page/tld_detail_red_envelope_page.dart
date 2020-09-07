import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_detail_red_envelope_content_cell.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/View/tld_detail_red_envelope_header_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TLDDetailRedEnvelopePage extends StatefulWidget {
  TLDDetailRedEnvelopePage({Key key}) : super(key: key);

  @override
  _TLDDetailRedEnvelopePageState createState() => _TLDDetailRedEnvelopePageState();
}

class _TLDDetailRedEnvelopePageState extends State<TLDDetailRedEnvelopePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'detail_red_envelope_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).detailRedEnvelope,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 210, 49, 67),
        actionsForegroundColor: Colors.white,
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 125 * 7,
          child :  Image.asset("assetss/images/detail_red_packet_bg.png",fit: BoxFit.fill,)),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0){
                return TLDDetailRedEnvelopeHeaderCell();
              }else{
                return TLDDetailRedEnvelopeContentCell();
              }
           },
          ),
          )
      ],
    );
  }

}