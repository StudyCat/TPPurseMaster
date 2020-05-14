import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TLDTransferAccountsInputRowViewType{
    allTransfer,
    normal,
    scanCode
}

class TLDTransferAccountsInputRowView extends StatefulWidget {
  TLDTransferAccountsInputRowView({Key key,this.type,this.didClickScanBtnCallBack}) : super(key: key);

  final TLDTransferAccountsInputRowViewType type;

  final Function didClickScanBtnCallBack;
  
  @override
  _TLDTransferAccountsInputRowViewState createState() => _TLDTransferAccountsInputRowViewState();
}

class _TLDTransferAccountsInputRowViewState extends State<TLDTransferAccountsInputRowView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color : Color.fromARGB(255, 242, 242, 242),
      ),
      child: _getBodyContent(context), 
    );
  }

  Widget _getBodyContent(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    if (widget.type == TLDTransferAccountsInputRowViewType.allTransfer) {
      return Row(
        children: <Widget>[
          Container(
                 width: screenSize.width - ScreenUtil().setWidth(260),
                 alignment: Alignment.topCenter,
                 child: _getTextField(),
               ),
               Container(height: ScreenUtil().setHeight(40), child: VerticalDivider(color: Color.fromARGB(255, 187, 187, 187))),
               Container(
                 padding: EdgeInsets.only(left : 5),
                 width: ScreenUtil().setWidth(120),
                 height: ScreenUtil().setHeight(60),
                 child: CupertinoButton(
                   padding: EdgeInsets.all(0),
                   child: Text('全部转出',style : TextStyle(fontSize : 14 , color : Color.fromARGB(255, 51, 114, 245)),),
                   onPressed: (){
                      
                   }),
               ),
        ],
      );
    }else if (widget.type == TLDTransferAccountsInputRowViewType.normal){
      return _getTextField();
    }else{
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
                 width: screenSize.width - ScreenUtil().setWidth(220),
                 alignment: Alignment.topCenter,
                 child: _getTextField(),
               ),
               Container(
                 padding: EdgeInsets.only(left : 5),
                 width: ScreenUtil().setWidth(100),
                 height: ScreenUtil().setHeight(60),
                 child: CupertinoButton(
                   padding: EdgeInsets.all(0),
                   child: Icon(IconData(0xe606,fontFamily : 'appIconFonts'),color: Theme.of(context).primaryColor,),
                   onPressed: widget.didClickScanBtnCallBack),
               ),
        ],
      );
    }
  }


  Widget _getTextField(){
    return CupertinoTextField(
      style: TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),
      decoration: BoxDecoration(
        border : Border.all(
          color : Color.fromARGB(0, 0, 0, 0)
        )
      ),
      padding: EdgeInsets.only(top : ScreenUtil().setHeight(24),left: ScreenUtil().setWidth(20)),
    );
  }
}