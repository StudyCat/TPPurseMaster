import 'package:dragon_sword_purse/NewMission/FirstPage/View/tld_publish_mission_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDNewMissionNoPublishMissionView extends StatefulWidget {
  TLDNewMissionNoPublishMissionView({Key key,this.didClickCallBack}) : super(key: key);

  final Function didClickCallBack;

  @override
  _TLDNewMissionNoPublishMissionViewState createState() => _TLDNewMissionNoPublishMissionViewState();
}

class _TLDNewMissionNoPublishMissionViewState extends State<TLDNewMissionNoPublishMissionView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: FractionalOffset(0.9, 0.95),
      children: <Widget>[
        Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(250)),
              child: Center(
                  child: Image.asset('assetss/images/no_data.png'),
              )),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(68)),
              child: Text('暂无发布的任务',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(28),
                      color: Color.fromARGB(255, 51, 51, 51))),
            ),
          ],
        )),
        TLDPublishMissionButton(
          didClickCallBack: ()=>widget.didClickCallBack(),
        )
      ],
    );
  }
}