import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceWithdrawListCell extends StatefulWidget {
  TLDAcceptanceWithdrawListCell({Key key,this.didClickIMBtnCallBack}) : super(key: key);

  final Function didClickIMBtnCallBack;

  @override
  _TLDAcceptanceWithdrawListCellState createState() => _TLDAcceptanceWithdrawListCellState();
}

class _TLDAcceptanceWithdrawListCellState extends State<TLDAcceptanceWithdrawListCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top : ScreenUtil().setHeight(10)),
       child: Container(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
            decoration : BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                _getHeaderRowView(),
                _getMissionInfoView(),
                Padding(
                  padding:  EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                  child: _getDateRowView(),
                  )
              ],
            ),
          ),
    );
  }

  Widget _getHeaderRowView(){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - ScreenUtil().setWidth(80),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:<Widget>[
          Text('任务编号：' + '4564564564564',style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153))),
        GestureDetector(
          onTap: widget.didClickIMBtnCallBack,
          child: Container(
          width: ScreenUtil().setWidth(74),
          height: ScreenUtil().setHeight(60),
          decoration: BoxDecoration(
            borderRadius : BorderRadius.only(topLeft:Radius.circular(ScreenUtil().setHeight(30)),bottomLeft:Radius.circular(ScreenUtil().setHeight(30))),
            color: Theme.of(context).primaryColor
          ),
          child: Icon(IconData(0xe609,fontFamily : 'appIconFonts'),color: Colors.white,),
        ),
        )
      ]
    ),
    );
  }

  Widget _getMissionInfoView(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          _getMissionInfoColumWidget('数量', '100TLD', null),
          _getMissionInfoColumWidget('金额',  '1839CNY', null),
          _getMissionInfoColumWidget('状态', '待支付', Color.fromARGB(255, 208, 2, 27))
        ]
      ),
    );
  }

  Widget _getMissionInfoColumWidget(String title,String content,Color color){
    return Column(
      children: <Widget>[
        Text(title,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:Color.fromARGB(255, 102, 102, 102)),),
        Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(content,style: TextStyle(fontSize:ScreenUtil().setSp(28),color:color != null ? color : Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _getDateRowView(){
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:<Widget>[
        Offstage(
          offstage:true,
          child: Container(
            width : ScreenUtil().setWidth(120),
            height: ScreenUtil().setHeight(40),
            decoration: BoxDecoration(
              border : Border.all(color:Color.fromARGB(255, 217, 176, 123),width:0.5),
              borderRadius : BorderRadius.all(Radius.circular(4)),
              color :Theme.of(context).hintColor
            ),
            child: Center(
              child : Text('我发起的',style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 121, 87, 43)))
            ),
          )
        ),
        Padding(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
          child : Text('2020-04-30 10:59',style:TextStyle(fontSize:ScreenUtil().setSp(24),color:Color.fromARGB(255, 153, 153, 153)))
          )
      ]
    ),
    );
  }
}