import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'flutter_xlider.dart';

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
            height: ScreenUtil().setHeight(200),
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
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(24)),
    ));
  }

  Widget getSliderView(){
    return Container(
      padding : EdgeInsets.only(right : ScreenUtil().setWidth(20),left : ScreenUtil().setWidth(20),top : ScreenUtil().setWidth(8)),
      child :FlutterSlider(
              values: [10],
              min: 0,
              max: 100,
              handlerHeight: ScreenUtil().setHeight(40),
              handlerWidth: ScreenUtil().setHeight(40),
              trackBar: FlutterSliderTrackBar(
                inactiveTrackBarHeight: ScreenUtil().setHeight(40),
                activeTrackBarHeight: ScreenUtil().setHeight(40),
                inactiveTrackBar: BoxDecoration(
                  borderRadius:  BorderRadius.circular(20.0),
                  color: Color.fromARGB(255, 148, 170, 218)
                ),
                activeTrackBar: BoxDecoration(
                  borderRadius:  BorderRadius.circular(20.0),
                  color: Theme.of(context).primaryColor
                ),
                ),
              handler: FlutterSliderHandler(
                child : Container(
                  decoration: BoxDecoration(
                  borderRadius:  BorderRadius.circular(20.0),
                  color: Theme.of(context).primaryColor
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                ),
                ),
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                setState(() {});
              },
            ),
    );
  }

}