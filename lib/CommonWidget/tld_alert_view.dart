import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TLDAlertViewType{
  normal,
  input
}


class TLDAlertView extends StatefulWidget {
  TLDAlertView({Key key,this.title,this.type,this.alertString,this.didClickSureBtn,this.textEditingCallBack}) : super(key: key);
  final String alertString;
  final String title;
  final TLDAlertViewType type;
  final Function didClickSureBtn;
  final ValueChanged<String> textEditingCallBack;
  @override
  _TLDAlertViewState createState() => _TLDAlertViewState();
}

class _TLDAlertViewState extends State<TLDAlertView> {

  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController();
    _controller.addListener((){
      widget.textEditingCallBack(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title,style: TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(28))),
      content: getContetnView(context),
      actions: <Widget>[
        CupertinoDialogAction(child: Text('取消',style : TextStyle(fontSize : ScreenUtil().setSp(28),color: Color.fromARGB(255, 102, 102, 102))), onPressed: (){
          Navigator.of(context).pop();
        }),
        CupertinoDialogAction(child: Text('确定',style : TextStyle(fontSize : ScreenUtil().setSp(28),color: Theme.of(context).primaryColor)), onPressed: (){
          Navigator.of(context).pop();
          widget.didClickSureBtn();
        }),
      ],
    );
  }

  Widget getContetnView(BuildContext context){
    if (widget.type == TLDAlertViewType.input){
      return Container(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
        decoration: BoxDecoration(
          borderRadius : BorderRadius.all(Radius.circular(4)),
        ),
        margin: EdgeInsets.only(left: ScreenUtil().setWidth(20) , right: ScreenUtil().setWidth((20))),
        child: CupertinoTextField(
          controller: _controller,
          placeholder: '限20字以内',
          decoration: BoxDecoration(
            color : Color.fromARGB(255, 242, 242, 242),
          ),
          placeholderStyle: TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 153, 153, 153)),
        ),
      );
    }else{
      return Text(widget.alertString);
    }
  }
}