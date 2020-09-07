import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TLDRedEnvelopeCellType{
  finished,
  unFinished
}

class TLDRedEnvelopeCell extends StatefulWidget {
  TLDRedEnvelopeCell({Key key,this.type}) : super(key: key);

  final TLDRedEnvelopeCellType type;

  @override
  _TLDRedEnvelopeCellState createState() => _TLDRedEnvelopeCellState();
}

class _TLDRedEnvelopeCellState extends State<TLDRedEnvelopeCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(10)),
      child: Container(
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        height: (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) / 1059 * 312,
        child : Stack(
          children : <Widget>[
            Image.asset(widget.type == TLDRedEnvelopeCellType.unFinished ? "assetss/images/unfinished_red_envelope.png" : "assetss/images/finished_red_envelope.png",fit: BoxFit.fill,),
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
              style: TextStyle(fontSize : ScreenUtil().setSp(20),fontWeight :FontWeight.bold,color: widget.type == TLDRedEnvelopeCellType.unFinished ? Colors.white : Color.fromARGB(255, 51, 51, 51)),
              children: <InlineSpan>[
                 TextSpan(
                text : '100000',
                style: TextStyle(fontSize : ScreenUtil().setSp(50),fontWeight :FontWeight.bold,color:  widget.type == TLDRedEnvelopeCellType.unFinished ? Colors.white : Color.fromARGB(255, 51, 51, 51)),
              ),
              
            ]
            ),
          ),
          Text('可抢50份',style: TextStyle(fontSize : ScreenUtil().setSp(28),fontWeight :FontWeight.bold,color:  widget.type == TLDRedEnvelopeCellType.unFinished ? Colors.white : Color.fromARGB(255, 51, 51, 51)),)
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
         Text(I18n.of(context).quatoRedEnvelopes,style: TextStyle(fontSize : ScreenUtil().setSp(28),fontWeight :FontWeight.bold,color: Color.fromARGB(255, 51, 51, 51)),),
         Text('有效期至：2020-09-23',style: TextStyle(fontSize : ScreenUtil().setSp(28),color: widget.type == TLDRedEnvelopeCellType.unFinished ? Theme.of(context).hintColor : Color.fromARGB(255, 153, 153, 153)),)
        ],
      ),
    );
  }

}