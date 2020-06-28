import 'package:dragon_sword_purse/CommonWidget/tld_amount_text_input_fprmatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDBuySearchField extends StatefulWidget {
  TLDBuySearchField(
      {Key key,
      this.textFieldDidChangeCallBack,
      this.didClickSearchBtnCallBack})
      : super(key: key);

  final Function(String) textFieldDidChangeCallBack;

  final Function didClickSearchBtnCallBack;

  @override
  _TLDBuySearchFieldState createState() => _TLDBuySearchFieldState();
}

class _TLDBuySearchFieldState extends State<TLDBuySearchField> {
  TextEditingController _textEditingController;

  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusNode = FocusNode();

    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      widget.textFieldDidChangeCallBack(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width - 30,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenSize.width - ScreenUtil().setWidth(230),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _textEditingController,
                    // focusNode: _focusNode,
                    inputFormatters: [TLDAmountTextInputFormatter()],
                    textInputAction: TextInputAction.search,
                    onSubmitted:(str)=> widget.didClickSearchBtnCallBack(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '请输入TLD数量',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 153, 153, 153),
                          fontSize: 12),
                    ),
                    style: TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51), fontSize: 12),
                  ),
                ),
                Container(
                    height: ScreenUtil().setHeight(40),
                    child: VerticalDivider(
                        color: Color.fromARGB(255, 187, 187, 187))),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  width: ScreenUtil().setWidth(90),
                  height: ScreenUtil().setHeight(60),
                  child: CupertinoButton(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        '查询',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: widget.didClickSearchBtnCallBack),
                ),
              ],
            )),
      ),
    );
  }
}
