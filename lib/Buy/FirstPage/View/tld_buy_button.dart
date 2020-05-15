import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget picAndTextButton(String imgpath,String text,Function onPress,double buttonWidth) {
  return Container(
    width: ScreenUtil().setWidth(buttonWidth),
    height: ScreenUtil().setWidth(buttonWidth / 128 * 60),
    decoration: BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: AssetImage(imgpath),
        fit: BoxFit.fill
      ),
    ),
    alignment: Alignment.center,
    child: FlatButton(
      onPressed: onPress,
      child: Text(text,style: TextStyle(color : Colors.white,fontSize: ScreenUtil().setSp(26)),maxLines: 1,),
      color: Colors.transparent,
      padding: EdgeInsets.all(0),
      ),
  );
}
