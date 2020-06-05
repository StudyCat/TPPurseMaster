import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDInputView extends StatefulWidget {
  TLDInputView({Key key}) : super(key: key);

  @override
  _TLDInputViewState createState() => _TLDInputViewState();
}

class _TLDInputViewState extends State<TLDInputView> {

  TextEditingController _controller;

  String _text;

  bool _isOpenToolView;

  CupertinoTextField _textField;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isOpenToolView = false;

    _controller = TextEditingController();
    _text = '';
    _controller.addListener((){
      setState(() {
       _text = _controller.text; 
      });
    });

    _textField =  CupertinoTextField(
                      controller: _controller,
                      placeholder: '请输入您想说的话',
                      placeholderStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          color: Color.fromARGB(255, 102, 102, 102)),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 242, 242, 242),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          color: Color.fromARGB(255, 51, 51, 51)),
                    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: _isOpenToolView ? ScreenUtil().setHeight(240) : ScreenUtil().setHeight(170),
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(15),
          right: ScreenUtil().setWidth(15),
          left: ScreenUtil().setWidth(15)),
      child: _getToolView()
    );
  }

  Widget _getToolView(){
    if (_isOpenToolView) {
      return Column(
        children: <Widget>[
          (_text.length == 0) ? _getNoWordInputView() : _getHaveWordInputView(),
          _getTakePicView()
        ],
      );
    }else{
      return  (_text.length == 0) ? _getNoWordInputView() : _getHaveWordInputView();
    }
  }

  Widget _getNoWordInputView(){
     return Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    height: ScreenUtil().setHeight(88),
                    child: _textField),
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(34)),
                child: IconButton(
                    icon: Icon(IconData(0xe67e, fontFamily: 'appIconFonts'),
                        size: ScreenUtil().setWidth(60)),
                    onPressed: () {
                      setState(() {
                        _isOpenToolView = !_isOpenToolView;
                      });
                    }),
              )
            ],
          );
  }

  Widget _getHaveWordInputView(){
    return Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    height: ScreenUtil().setHeight(88),
                    child: _textField),
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(34)),
                height: ScreenUtil().setHeight(88),
                width: ScreenUtil().setWidth(130),
                child: CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(0),
                    child: Text('发送',style : TextStyle(color : Colors.white,fontSize : ScreenUtil().setSp(28))),
                    // padding: EdgeInsets.all(0),
                    onPressed: () {}),
              )
            ],
          );
  }

  Widget _getTakePicView(){
    return Padding(
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,  
        children : <Widget>[
          Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(20)),
            child: IconButton(icon: Icon(IconData(0xe642,fontFamily: 'appIconFonts',),size:ScreenUtil().setWidth(60),), onPressed: (){}),
          ),
          Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(80)),
            child: IconButton(icon: Icon(IconData(0xe603,fontFamily: 'appIconFonts'),size: ScreenUtil().setWidth(60),), onPressed: (){}),
          )
        ],
      ),
    );
  }

}
