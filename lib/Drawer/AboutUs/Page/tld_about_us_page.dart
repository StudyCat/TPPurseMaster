import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidget/tld_clip_common_cell.dart';
import '../View/tld_about_us_header_cell.dart';

class TLDAboutUsPage extends StatefulWidget {
  TLDAboutUsPage({Key key}) : super(key: key);

  @override
  _TLDAboutUsPageState createState() => _TLDAboutUsPageState();
}

class _TLDAboutUsPageState extends State<TLDAboutUsPage> {
  List titles = [
    '官网',
    '版本更新',
  ];

  List contents = ['http://www.tlddollar.com', '当前是最新版本'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'about_us_page',
        transitionBetweenRoutes: false,
        middle: Text('关于我们'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return TLDAboutUsHeaderCell();
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2),
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TLDClipCommonCell(
                type: TLDClipCommonCellType.normal,
                title: titles[index - 1],
                titleStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Color.fromARGB(255, 51, 51, 51)),
                content: contents[index - 1],
                contentStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 153, 153, 153)),
              ),
            );
          }
        });
  }
}
