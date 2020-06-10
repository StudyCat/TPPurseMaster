import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

class TLDBuyActionSheetInputView extends StatefulWidget {
  TLDBuyActionSheetInputView({Key key,this.max,this.inputStringCallBack,this.currentAmount}) : super(key: key);

  final String max;

  final String currentAmount;

  final Function(String) inputStringCallBack;

  @override
  _TLDBuyActionSheetInputViewState createState() =>
      _TLDBuyActionSheetInputViewState();
}

class _TLDBuyActionSheetInputViewState
    extends State<TLDBuyActionSheetInputView> {
  TextEditingController _controller;

  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(() {
       String text = _controller.text;
        String result;
        setState(() {
          if(text.length == 0){
            result = '0';
          }else{
             if(double.parse(text) > double.parse(widget.currentAmount)){
                _focusNode.unfocus();
                _controller.text = widget.currentAmount;
                result = widget.currentAmount;
              }else {
                result = text;
              }
          }
      });
      widget.inputStringCallBack(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color.fromARGB(255, 242, 242, 242),
      ),
      child: _getBodyContent(context),
    );
  }

  Widget _getBodyContent(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
        Container(
          width: screenSize.width - ScreenUtil().setWidth(300),
          alignment: Alignment.topCenter,
          child: _getTextField(),
        ),
        Container(
          padding : EdgeInsets.only(left : 5),
          child: Text('TLD',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Theme.of(context).primaryColor, decoration: TextDecoration.none,fontWeight: FontWeight.w400,)),
        ),
        Container(
            height: ScreenUtil().setHeight(40),
            child: VerticalDivider(color: Color.fromARGB(255, 187, 187, 187))),
        Container(
          padding: EdgeInsets.only(left: 5),
          width: ScreenUtil().setWidth(130),
          height: ScreenUtil().setHeight(60),
          child: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: Text(
                '全部购买',
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).primaryColor,),
              ),
              onPressed: () {
                _focusNode.unfocus();
                String allAmount =  widget.currentAmount;
                _controller.text = allAmount;
                widget.inputStringCallBack(allAmount);
              }),
        ),
      ],
    );
  }

  Widget _getTextField() {
    return CupertinoTextField(
      style: TextStyle(
          fontSize: ScreenUtil().setSp(24),
          color: Color.fromARGB(255, 51, 51, 51)),
      decoration:
          BoxDecoration(border: Border.all(color: Color.fromARGB(0, 0, 0, 0))),
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(24), left: ScreenUtil().setWidth(20)),
      placeholder: '请输入购买的数量',
      placeholderStyle: TextStyle(
          fontSize: ScreenUtil().setSp(24),
          color: Color.fromARGB(255, 153, 153, 153),height: 1.1),
      inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly
      ],
      controller: _controller,
      focusNode: _focusNode,
    );
  }
  
}
