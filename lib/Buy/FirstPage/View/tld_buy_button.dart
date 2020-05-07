import 'package:flutter/material.dart';

Widget picAndTextButton(String imgpath,String text,Function onPress) {
  return Container(
    width: 64,
    height: 30,
    padding: EdgeInsets.only(right : 0),
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
      child: Text(text,style: TextStyle(color : Colors.white),),
      color: Colors.transparent,
      ),
  );
}
