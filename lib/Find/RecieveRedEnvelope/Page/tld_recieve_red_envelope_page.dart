import 'package:dragon_sword_purse/Find/RecieveRedEnvelope/View/tld_unopen_red_envelope_alert_view.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDRecieveRedEnvelopePage extends StatefulWidget {
  TLDRecieveRedEnvelopePage({Key key}) : super(key: key);

  @override
  _TLDRecieveRedEnvelopePageState createState() => _TLDRecieveRedEnvelopePageState();
}

class _TLDRecieveRedEnvelopePageState extends State<TLDRecieveRedEnvelopePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'recieve_red_envelope_page',
        transitionBetweenRoutes: false,
        middle: Text(
          I18n.of(context).recieveRedEnvelope,
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
     return ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
         return Padding(
          padding: EdgeInsets.only(
            top : ScreenUtil().setHeight(10),
            left: ScreenUtil().setWidth(30),
            right: ScreenUtil().setWidth(30),
            bottom: ScreenUtil().setHeight(20)
          ),
          child: Container(
            height : ScreenUtil().setHeight(96),
            child :CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(I18n.of(context).recieve,style : TextStyle(
                fontSize : ScreenUtil().setSp(30),
                color :Theme.of(context).hintColor
              )),
              color: Theme.of(context).primaryColor,
              onPressed: (){
                showDialog(context: context,builder :(context){
                  return TLDUnopenRedEnvelopeAlertView();
                });
              }),
          )
        );
        }else{
          // TLDRedEnvelopeCellType type = TLDRedEnvelopeCellType.unFinished;
          // if (index == 2){
          //   type = TLDRedEnvelopeCellType.finished;
          // }
          // return GestureDetector(
          //   onTap : (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailRedEnvelopePage()));
          //   },
          //   child : TLDRedEnvelopeCell(type: type,)
          // );
        }
     },
    );
  }
}