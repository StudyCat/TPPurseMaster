import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageButton extends StatefulWidget {
  final Function didClickCallBack;

  final bool isHaveUnReadMessage;

  final Color color;

  MessageButton({Key key,this.color,this.didClickCallBack,this.isHaveUnReadMessage = false}) : super(key: key);

  @override
  _MessageButtonState createState() => _MessageButtonState();
}

class _MessageButtonState extends State<MessageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
       child: Stack(
         alignment : FractionalOffset(0.8,0.3),
         children: <Widget>[
           CupertinoButton(
             child: Icon(IconData(0xe63f,fontFamily: 'appIconFonts'),color: widget.color != null ? widget.color : Color.fromARGB(255, 51, 51, 51),),
             onPressed: () => widget.didClickCallBack(),
              padding: EdgeInsets.all(0),
            ),
           Offstage(
             offstage: !widget.isHaveUnReadMessage,
             child: ClipRRect(
             borderRadius: BorderRadius.all(Radius.circular(3.5)),
             child : Container(
              height: 7,
              width: 7,
              color: Colors.red, 
             ),
           ),
           )
         ],
       ),
    );
  }
}