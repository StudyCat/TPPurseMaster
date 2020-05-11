import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../View/tld_my_purse_header.dart';
import '../View/tld_my_purse_content_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Settings/Page/tld_purse_setting_page.dart';

class TLDMyPursePage extends StatefulWidget {
  TLDMyPursePage({Key key}) : super(key: key);

  @override
  _TLDMyPursePageState createState() => _TLDMyPursePageState();
}

class _TLDMyPursePageState extends State<TLDMyPursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('data'),
        trailing: Container(
            width: ScreenUtil().setWidth(160),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                    child: Icon(
                      IconData(0xe663, fontFamily: 'appIconFonts'),
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }),
                CupertinoButton(
                    child: Icon(
                      IconData(0xe615, fontFamily: 'appIconFonts'),
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    padding: EdgeInsets.all(0),
                    minSize: 20,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TLDPurseSettingPage();
                          },
                        ),
                      );
                    }),
              ],
            )),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return Column(children: <Widget>[
      TLDMyPurseHeaderView(),
      Expanded(
        child: TLDMyPurseContentView(),
      )
    ]);
  }
}
