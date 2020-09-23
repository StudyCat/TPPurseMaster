import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TLDAAAPersonCenterHeaderBottomView extends StatefulWidget {
  TLDAAAPersonCenterHeaderBottomView({Key key,this.tabController}) : super(key: key);

  final TabController tabController;

  @override
  _TLDAAAPersonCenterHeaderBottomViewState createState() => _TLDAAAPersonCenterHeaderBottomViewState();
}

class _TLDAAAPersonCenterHeaderBottomViewState extends State<TLDAAAPersonCenterHeaderBottomView> {
  List _tabTitles = ['好友发起','我的发起'];

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

   Widget _getBody(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(40),
          color: Theme.of(context).primaryColor,
        ),
        TabBar(
            tabs: _tabTitles.map((title) {
              return Tab(text: title);
            }).toList(),
            labelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(24)),
            indicatorColor: Theme.of(context).hintColor,
            labelColor: Color.fromARGB(255, 51, 51, 51),
            unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
            controller: widget.tabController,
            indicatorSize: TabBarIndicatorSize.label,
          )
      ],
    );
  }
}