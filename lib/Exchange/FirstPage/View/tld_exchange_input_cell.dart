import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDExchangeInputCell extends StatefulWidget {
  final String title;

  TLDExchangeInputCell({Key key, this.title}) : super(key: key);

  @override
  _TLDExchangeInputCellState createState() => _TLDExchangeInputCellState();
}

class _TLDExchangeInputCellState extends State<TLDExchangeInputCell> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 15, top: 20, right: 15),
      width: screenSize.width - 30,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: Container(
            color: Colors.white,
            height: ScreenUtil().setHeight(88),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                  ),
                  child: Text(widget.title,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          color: Color.fromARGB(255, 51, 51, 51))),
                ),
                getRightWidget()
              ],
            ),
          )),
    );
  }

  Widget getRightWidget() {
    return Container(
      width: ScreenUtil().setWidth(122),
      height: ScreenUtil().setWidth(48),
      padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
      child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Color.fromARGB(255, 203, 203, 203)),
        ),
      ),
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(24)),
    ));
  }
}
