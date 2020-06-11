import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_system_message_cell.dart';

class TLDSystemMessageContentPage extends StatefulWidget {
  TLDSystemMessageContentPage({Key key}) : super(key: key);

  @override
  _TLDSystemMessageContentPageState createState() => _TLDSystemMessageContentPageState();
}

class _TLDSystemMessageContentPageState extends State<TLDSystemMessageContentPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
      return TLDSystemMessageCell(title: '我已支付，请发放积分。');
     },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}