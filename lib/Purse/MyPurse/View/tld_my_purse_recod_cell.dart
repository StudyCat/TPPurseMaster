import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDMyPurseRecordCell extends StatefulWidget {
  TLDMyPurseRecordCell({Key key}) : super(key: key);

  @override
  _TLDMyPurseRecordCellState createState() => _TLDMyPurseRecordCellState();
}

class _TLDMyPurseRecordCellState extends State<TLDMyPurseRecordCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(2)),
      child : ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          margin : EdgeInsets.all(0),
          height: ScreenUtil().setHeight(202),
          child: Row(
            children : <Widget>[
              Container(
                width: ScreenUtil().setWidth(8),
                height: ScreenUtil().setHeight(168),
                child: Image.asset('assetss/images/record_black.png'),
              ),
              Expanded(child: getContentView())
            ],
          ),
        ), 
      )
      );
  }

  Widget getContentView(){
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(20), ScreenUtil().setWidth(20), ScreenUtil().setWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          getAdressView(context),
          getNumLabel(context),
          getOtherInfoView(context),
        ],
      ));
  }

  Widget getAdressView(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Text('收款地址',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),),
        Container(
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(20)),
          width: size.width - ScreenUtil().setWidth(230),
          child: Text('dssadasdsafgefrgdfdsgasgasgfsadfsafasfsafsafsafsafasfasfafsafsafsa',maxLines : 1 , style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),overflow: TextOverflow.ellipsis,),
        ),
      ],
    );
  }

  Widget getNumLabel(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),top: ScreenUtil().setWidth(10)),
      child: Text('-4645465 TLD',style: TextStyle(fontSize : ScreenUtil().setSp(32),color: Color.fromARGB(255, 208, 27, 1)),textAlign: TextAlign.right,),
    );
  }

  Widget getOtherInfoView(BuildContext context){
     return Container(
       padding: EdgeInsets.only(
         top : ScreenUtil().setHeight(22),
       ),
       child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('2020.08.10',style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51)),),
        Text('手续费 0.5 TLD',maxLines : 1 , style : TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),overflow: TextOverflow.ellipsis,
        )]
    ),
     );
  }
  
}