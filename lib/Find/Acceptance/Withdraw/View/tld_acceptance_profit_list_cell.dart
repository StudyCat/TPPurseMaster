import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceProfitListCell extends StatefulWidget {
  TLDAcceptanceProfitListCell({Key key}) : super(key: key);

  @override
  _TLDAcceptanceProfitListCellState createState() => _TLDAcceptanceProfitListCellState();
}

class _TLDAcceptanceProfitListCellState extends State<TLDAcceptanceProfitListCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top : ScreenUtil().setHeight(2)),
       child: Container(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20),left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('票据ID：xxxx',style:TextStyle(fontSize : ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153))),
                _getProfitRowWidget(),
                Padding(
                  padding:  EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                  child: _getDateWidget(),
                  )
              ],
            ),
          ),
    );
  }

  Widget _getProfitRowWidget(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children : <InlineSpan>[
                WidgetSpan(
                  child : CachedNetworkImage(imageUrl:'http://oss.thyc.com/2020/07/14/073e999580b5451797f4c7b16b188194.png',width: ScreenUtil().setWidth(32),height: ScreenUtil().setWidth(32),),
                ),
                TextSpan(
                  text : '  今日收益：5TLD',
                  style : TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 102, 102, 102))
                )
              ]
            ),
          ),
          Text('1份',style:TextStyle(fontSize : ScreenUtil().setSp(28),color:Color.fromARGB(255, 57, 57, 57))),
        ],
      ),
      );
  }

  Widget _getDateWidget(){
    return Container(
      width : MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      child: Text('2020-04-30 10:59',style:TextStyle(fontSize : ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,),
    );
  }

}