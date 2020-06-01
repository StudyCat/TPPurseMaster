import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_my_purse_recod_cell.dart';

class TLDMyPurseRecordPage extends StatefulWidget {
  TLDMyPurseRecordPage({Key key,this.index}) : super(key: key);
  final int index;
  @override
  _TLDMyPurseRecordPageState createState() => _TLDMyPurseRecordPageState();
}

class _TLDMyPurseRecordPageState extends State<TLDMyPurseRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: getListView(),
    );
  }

  Widget getListView(){
    return Padding(
      padding: EdgeInsets.only(top :ScreenUtil().setHeight(20)),
      child: ListView.builder(
        itemCount: widget.index + 1,
        itemBuilder: (BuildContext context , int index){
          return TLDMyPurseRecordCell();
      }),
      );
  }

}