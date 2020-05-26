import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDSaleSuspendButton extends StatefulWidget {
  TLDSaleSuspendButton({Key key,this.didClickCallBack}) : super(key: key);
  
  final Function didClickCallBack;

  @override
  _TLDSaleSuspendButtonState createState() => _TLDSaleSuspendButtonState();
}

class _TLDSaleSuspendButtonState extends State<TLDSaleSuspendButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.didClickCallBack();
      },
      child: Text('\u{E6ee}',
        style: TextStyle(
            fontFamily: 'appIconFonts',
            fontSize: ScreenUtil().setWidth(96),
            color: Theme.of(context).primaryColor,
            shadows: [
              BoxShadow(
                color: Color.fromARGB(255, 102, 102, 102),
                offset: Offset(2.0,3.0),
                blurRadius: 6
              )
            ]),
            ),
    );
  }
}
