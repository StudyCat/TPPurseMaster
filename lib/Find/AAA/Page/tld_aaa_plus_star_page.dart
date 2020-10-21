import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_plus_star_model_manager.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_action_sheet.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_cell.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_notice_cell.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TLDAAAPlusStarPage extends StatefulWidget {
  TLDAAAPlusStarPage({Key key}) : super(key: key);

  @override
  _TLDAAAPlusStarPageState createState() => _TLDAAAPlusStarPageState();
}

class _TLDAAAPlusStarPageState extends State<TLDAAAPlusStarPage> {

  RefreshController _refreshController;

  TLDAAAPlusStarModelManager _modelManager;

  List _dataSource = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _refreshController = RefreshController(initialRefresh:false);

    _modelManager = TLDAAAPlusStarModelManager();
    _getStarList();
  }

  void _getStarList(){
    _modelManager.getStarList((List starList){
      _refreshController.refreshCompleted();
      _dataSource = [];
      if (mounted){
        setState(() {
          _dataSource.addAll(starList);
        });
      }
    }, (TLDError error){
      _refreshController.refreshCompleted();
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'plus_star_page',
        transitionBetweenRoutes: false,
        middle: Text('团队升星'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getRefreshWidget(),
      backgroundColor: Color.fromARGB(255, 242, 242, 242));
  }

  Widget _getRefreshWidget(){
    return SmartRefresher(
      controller: _refreshController,
      child: _getBodyWidget(),
      header: WaterDropHeader(
        complete : Text(I18n.of(context).refreshComplete),
      ),
      onRefresh: (){
        _getStarList();
      }
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _dataSource.length + 1,
      itemBuilder: (BuildContext context, int index) {
      if (index == 0){
        return TLDAAAPlusStarNoticeCell();
      }else{
        TLDTeamStarModel model = _dataSource[index - 1];
        return TLDAAAPlusStarCell(
          starModel: model,
          didClickPlusStarButton: (){
            showModalBottomSheet(
              context: context,
              builder: (context) => TLDAAAPlusStarActionSheet()
            );
          },
        );
      }
     },
    );
  }
}
