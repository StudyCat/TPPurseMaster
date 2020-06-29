import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDGetMissionActionSheet extends StatefulWidget {
  TLDGetMissionActionSheet({Key key}) : super(key: key);

  @override
  _TLDGetMissionActionSheetState createState() => _TLDGetMissionActionSheetState();
}

class _TLDGetMissionActionSheetState extends State<TLDGetMissionActionSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Padding(
      padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
      height: ScreenUtil().setHeight(340),
      width: size.width,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('领取任务',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 51, 51, 51),
                  decoration: TextDecoration.none)),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: _getWalletAddressRowView(),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
            child: Container(
            width: size.width,
            height: ScreenUtil().setHeight(80),
            child: CupertinoButton(child: Text('确认领取',style: TextStyle(fontSize : ScreenUtil().setSp(28)),), onPressed: (){
            }
            ,color: Theme.of(context).primaryColor,padding: EdgeInsets.all(0),),
          )
          )],
      ),
    ),
    );
  }

  Widget _getWalletAddressRowView(){
    return Container(
      height: ScreenUtil().setHeight(88),
      padding: EdgeInsets.only(left :ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
        color : Color.fromARGB(255, 242, 242, 242),
        borderRadius:BorderRadius.all(Radius.circular(4))
      ),
      child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '钱包地址',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Row(children: <Widget>[
          Container(width : ScreenUtil().setWidth(400),child : Text(
            'huohwdo238932h9d2d20',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 153, 153, 153)),
          )),
          Icon(Icons.keyboard_arrow_right)
        ])
      ],
    ),
    );
  }

}