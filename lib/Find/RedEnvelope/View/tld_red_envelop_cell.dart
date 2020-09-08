import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TLDRedEnvelopeCellType{
  finished,
  unFinished
}

class TLDRedEnvelopeCell extends StatefulWidget {
  TLDRedEnvelopeCell({Key key,this.listModel}) : super(key: key);

  final TLDRedEnevelopeListModel listModel;

  @override
  _TLDRedEnvelopeCellState createState() => _TLDRedEnvelopeCellState();
}

class _TLDRedEnvelopeCellState extends State<TLDRedEnvelopeCell> {
  
  TLDRedEnvelopeCellType _type;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.listModel.status == 1){
      _type = TLDRedEnvelopeCellType.unFinished;
    }else{
      _type = TLDRedEnvelopeCellType.finished;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10)),
      child: Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        height: (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 1059 * 312,
        child : Stack(
          children : <Widget>[
            Image.asset(_type == TLDRedEnvelopeCellType.unFinished ? "assetss/images/unfinished_red_envelope.png" : "assetss/images/finished_red_envelope.png",fit: BoxFit.fill,),
            _getContentWidget()
          ]
        )
        ),
    );
  }

  Widget _getContentWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getLeftColumnWidget(),
        _getRightColumnWidget()
      ],
    );
  }

  Widget _getLeftColumnWidget(){
    double width = (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 21 * 7;
    return Container(
      width: width,
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            text: TextSpan(
              text: 'TLD',
              style: TextStyle(fontSize : ScreenUtil().setSp(20),fontWeight :FontWeight.bold,color: _type == TLDRedEnvelopeCellType.unFinished ? Colors.white : Color.fromARGB(255, 51, 51, 51)),
              children: <InlineSpan>[
                 TextSpan(
                text : widget.listModel.tldCount,
                style: TextStyle(fontSize : ScreenUtil().setSp(50),fontWeight :FontWeight.bold,color:  _type == TLDRedEnvelopeCellType.unFinished ? Colors.white : Color.fromARGB(255, 51, 51, 51)),
              ),
              
            ]
            ),
          ),
          Text(I18n.of(context).canSnatch + widget.listModel.redEnvelopeNum.toString() + I18n.of(context).part,style: TextStyle(fontSize : ScreenUtil().setSp(28),fontWeight :FontWeight.bold,color:  _type == TLDRedEnvelopeCellType.unFinished ? Colors.white : Color.fromARGB(255, 51, 51, 51)),)
        ],
      ),
    );
  }

  Widget _getRightColumnWidget(){
    double width = (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 69 * 37;
    return Container(
      width: width,
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right : 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         Text(widget.listModel.policy == 1 ?I18n.of(context).spellLuck : I18n.of(context).quatoRedEnvelopes ,style: TextStyle(fontSize : ScreenUtil().setSp(28),fontWeight :FontWeight.bold,color: Color.fromARGB(255, 51, 51, 51)),),
         Text( I18n.of(context).validUntil + _getDateTime(),style: TextStyle(fontSize : ScreenUtil().setSp(28),color: _type == TLDRedEnvelopeCellType.unFinished ? Theme.of(context).hintColor : Color.fromARGB(255, 153, 153, 153)),)
        ],
      ),
    );
  }

  String _getDateTime(){
    return formatDate(DateTime.fromMillisecondsSinceEpoch(widget.listModel.expireTime), [yyyy,'-',mm,'-',dd]);
  }

}