import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Rank/Model/tld_rank_accptance_model_manager.dart';
import 'package:dragon_sword_purse/Find/Rank/View/tld_rank_acceptance_cell.dart';
import 'package:dragon_sword_purse/Find/Rank/View/tld_rank_acceptance_header_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDRankAccptancePage extends StatefulWidget {
  TLDRankAccptancePage({Key key}) : super(key: key);

  @override
  _TLDRankAccptancePageState createState() => _TLDRankAccptancePageState();
}

class _TLDRankAccptancePageState extends State<TLDRankAccptancePage> {
 TLDRankAccptanceModelManager _modelManager;

  List _dataSource = [];

  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDRankAccptanceModelManager();

    _getRankList();
  }

  void _getRankList(){
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.getAcceptanceRankList((List rankList){
      _dataSource = [];
      if(mounted){
      setState(() {
        _isLoading = false;
        _dataSource.addAll(rankList);
      });
    }
    },(TLDError error){
      if(mounted){
      setState(() {
        _isLoading = false;
      });
    }
    Fluttertoast.showToast(msg: error.msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget());
  }

  Widget _getBodyWidget(){
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(20), ScreenUtil().setWidth(30), ScreenUtil().setHeight(40)),
      child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white
         ),
         child: ListView.builder(
           itemCount: _dataSource.length + 1,
           itemBuilder: (BuildContext context, int index) {
           if (index == 0){
             return TLDRankAcceptanceHeaderCell();
           }else{
             return TLDRankAcceptanceCell(rankModel: _dataSource[index - 1],);
           }
          },
         ),
      ), 
      );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}