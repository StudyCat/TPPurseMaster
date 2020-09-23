import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_friend_team_lock_cell.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_friend_team_open_cell.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_friend_team_unopen_cell.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_friend_team_unupgrade_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAAAFriendTeamPage extends StatefulWidget {
  TLDAAAFriendTeamPage({Key key}) : super(key: key);

  @override
  _TLDAAAFriendTeamPageState createState() => _TLDAAAFriendTeamPageState();
}

class _TLDAAAFriendTeamPageState extends State<TLDAAAFriendTeamPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'order_list_page',
        transitionBetweenRoutes: false,
        middle: Text('AAA'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
       if (index == 0){
         return TLDAAAFriendTeamOpenCell();
       }else if(index == 1){
         return TLDAAAFriendTeamUnOpenCell();
       }else if(index == 2){
         return TLDAAAFriendTeamUnUpgradeCell();
       }else{
         return TLDAAAFriendTeamLockCell();
       }
     },
    );
  }
}