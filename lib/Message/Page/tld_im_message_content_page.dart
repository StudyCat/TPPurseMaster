import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_im_message_cell.dart';

class TLDIMMessageContentPage extends StatefulWidget {
  TLDIMMessageContentPage({Key key}) : super(key: key);

  @override
  _TLDIMMessageContentPageState createState() => _TLDIMMessageContentPageState();
}

class _TLDIMMessageContentPageState extends State<TLDIMMessageContentPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
      return TLDIMMessageCell(title: '我已支付，请发放积分。');
     },
    );
  }
}