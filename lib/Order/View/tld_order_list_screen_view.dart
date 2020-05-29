import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_order_list_screen_content_view.dart';

class TLDOrderListScreenViewController extends ValueNotifier<bool>{
    TLDOrderListScreenViewController(bool isShow) : super(isShow);


}

class TLDOrderListScreenView extends StatefulWidget {
  TLDOrderListScreenView({Key key,this.controller,this.didClickSureBtnCallBack}) : super(key: key);

  final TLDOrderListScreenViewController controller;

  final Function(int) didClickSureBtnCallBack;

  @override
  _TLDOrderListScreenViewState createState() => _TLDOrderListScreenViewState();
}

class _TLDOrderListScreenViewState extends State<TLDOrderListScreenView>
    with TickerProviderStateMixin {
  // AnimationController _controller;
  bool isShow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener((){
       setState(() {
         isShow = widget.controller.value;
       });
    });
    isShow = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Offstage(
      offstage: isShow,
      child: Column(
        children: <Widget>[
          TLDOrderListScreenContentView(
            didClickSureBtnCallBack: (int status){
              widget.didClickSureBtnCallBack(status);
              widget.controller.value = true;
            },
          ),
          Expanded(
             child: GestureDetector(
               onTap:(){
                 widget.controller.value = !widget.controller.value;
               },
               child : Container(
            color: Color.fromARGB(150, 51, 51, 51),
            width: size.width,
             ),
          ))
        ],
      ),
    );
  }
}
