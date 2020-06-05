import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TLDRightImageBubbleView extends StatefulWidget {
  TLDRightImageBubbleView({Key key,this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  _TLDRightImageBubbleViewState createState() => _TLDRightImageBubbleViewState();
}

class _TLDRightImageBubbleViewState extends State<TLDRightImageBubbleView> {
  @override
  Widget build(BuildContext context) {
   return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
      decoration: BoxDecoration(
        color : Theme.of(context).primaryColor,
        borderRadius : BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
      ),
       child: CachedNetworkImage(imageUrl: widget.imageUrl,fit: BoxFit.fill,),
    );
  }
}