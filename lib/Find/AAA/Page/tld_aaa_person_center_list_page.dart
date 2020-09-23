import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_person_center_list_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TLDAAAPersonCenterListPage extends StatefulWidget {
  TLDAAAPersonCenterListPage({Key key}) : super(key: key);

  @override
  _TLDAAAPersonCenterListPageState createState() => _TLDAAAPersonCenterListPageState();
}

class _TLDAAAPersonCenterListPageState extends State<TLDAAAPersonCenterListPage> {
  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
      return TLDAAAPersonCenterListCell(index: index,);
     },
    );
  }

}