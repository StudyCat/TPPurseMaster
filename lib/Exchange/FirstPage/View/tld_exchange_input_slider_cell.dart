import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class TLDExchangeInputSliderCell extends StatefulWidget {
  final String title;
  TLDExchangeInputSliderCell({Key key,this.title}) : super(key: key);

  @override
  _TLDExchangeInputSliderCellState createState() => _TLDExchangeInputSliderCellState();
}

class _TLDExchangeInputSliderCellState extends State<TLDExchangeInputSliderCell> {
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
            height: ScreenUtil().setHeight(186),
            child: Column(
              children: <Widget>[
                getCellTopView(),
                getSliderView()
              ],
            ),
          )),
    );
  }

  Widget getCellTopView(){
    return  Container(
      padding : EdgeInsets.only(top : ScreenUtil().setWidth(20)),
      child : Row(
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
                getTextField()
              ],
            )
    );
  }

  Widget getTextField(){
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
      style: TextStyle(color: Color.fromARGB(255, 51, 114, 245), fontSize: ScreenUtil().setSp(24)),
    ));
  }

  Widget getSliderView(){
    return Container(
      padding : EdgeInsets.only(right : ScreenUtil().setWidth(20),left : ScreenUtil().setWidth(20),top : ScreenUtil().setWidth(13)),
      child : Slider(value: 0, onChanged: (double value){},)
    );
  }

}