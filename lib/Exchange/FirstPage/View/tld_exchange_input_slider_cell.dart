import 'package:date_format/date_format.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'flutter_xlider.dart';
import '../../../Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/services.dart';

class TLDExchangeInputSliderCell extends StatefulWidget {
  final String title;
  final TLDWalletInfoModel infoModel;
  final Function(String) inputCallBack;
  final FocusNode focusNode;
  TLDExchangeInputSliderCell({Key key,this.title,this.infoModel,this.inputCallBack,this.focusNode}) : super(key: key);

  @override
  _TLDExchangeInputSliderCellState createState() => _TLDExchangeInputSliderCellState();
}

class _TLDExchangeInputSliderCellState extends State<TLDExchangeInputSliderCell> {
  String _value = '0';

  TextEditingController _controller;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController(text: '0');
    _controller.addListener(() {
      String text = _controller.text;
      setState(() {
          if(text.length == 0){
            _value = '0';
          }else{
             if(double.parse(text) > double.parse(widget.infoModel.value)){
               widget.focusNode.unfocus();
              _controller.text = widget.infoModel.value;
              _value = widget.infoModel.value;
            }else{
              _value = text;
            }
          }
      });
      widget.inputCallBack(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 15, top: 1, right: 15),
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
    return Stack(
      alignment : FractionalOffset(0.8,0.6),
      children: <Widget>[
        Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setWidth(48),
      padding: EdgeInsets.only(right : ScreenUtil().setWidth(20)),
      child: CupertinoTextField(
      enabled: widget.infoModel == null ? false : true,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(24),textBaseline: TextBaseline.alphabetic),
      controller: _controller,
      focusNode: widget.focusNode,
      inputFormatters: [
        TLDAmountTextInputFormatter()
      ],
    )),
    Text('TLD',style:TextStyle(color: Theme.of(context).primaryColor, fontSize: ScreenUtil().setSp(24)))
      ],
    );
  }

  Widget getSliderView(){
    bool disabled = widget.infoModel == null;
    return Container(
      padding : EdgeInsets.only(right : ScreenUtil().setWidth(20),left : ScreenUtil().setWidth(20),top : ScreenUtil().setWidth(8)),
      child :FlutterSlider(
              values: [double.parse(_value)],
              min: 0,
              disabled: disabled,
              max: widget.infoModel == null ? 100 : double.parse(widget.infoModel.value),
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
                if(widget.infoModel != null){
                  setState(() {
                  widget.focusNode.unfocus();
                  _value = lowerValue.toString();
                  _controller.text = _value;
                });
                }else{
                  widget.focusNode.unfocus();
                  setState(() {
                    _value = '0';
                  });
                }
                widget.inputCallBack(_value);    
              },
            ),
    );
  }

}