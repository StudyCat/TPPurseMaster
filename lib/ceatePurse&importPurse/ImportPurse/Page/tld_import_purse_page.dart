import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'tld_import_purse_key_page.dart';
import 'tld_import_purse_word_page.dart';


class TLDImportPursePage extends StatefulWidget {
  TLDImportPursePage({Key key}) : super(key: key);

  @override
  _TLDImportPursePageState createState() => _TLDImportPursePageState();
}

class _TLDImportPursePageState extends State<TLDImportPursePage> with SingleTickerProviderStateMixin{

  TabController _tabController;

    List<String> _tabTitles = [
    "助记词",
    "私钥",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'import_purse_page',
        transitionBetweenRoutes: false,
        middle: Text('创建钱包'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body:  _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left : ScreenUtil().setWidth(50),right : ScreenUtil().setWidth(50),top: ScreenUtil().setHeight(20)),
            child: TabBar(
            tabs: _tabTitles.map((title) {
              return Tab(text: title);
            }).toList(),
            labelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Color.fromARGB(255, 51, 51, 51),
            unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
          ),
            ),
          Expanded(
              child: TabBarView(
            children: [
              TLDImportPurseWordPage(),
              TLDImportPurseKeyPage()
            ],
            controller: _tabController,
          ))
        ],
      );
  }

}