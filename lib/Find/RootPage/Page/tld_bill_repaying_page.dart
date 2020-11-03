import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/Find/AAA/View/tld_aaa_plus_star_notice_cell.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_bill_repaying_model_manager.dart';
import 'package:dragon_sword_purse/Find/RootPage/View/tld_bill_repaying_bottom_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDBillRepayingPage extends StatefulWidget {
  TLDBillRepayingPage({Key key}) : super(key: key);

  @override
  _TLDBillRepayingPageState createState() => _TLDBillRepayingPageState();
}

class _TLDBillRepayingPageState extends State<TLDBillRepayingPage> {

  TLDBillRepayingModelManager _modelManager;

  bool _isLoading = false;

  TLDBillRepayingModel _repayingModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDBillRepayingModelManager();
    _getRepayingInfo();
  }

  void _getRepayingInfo(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.getRepayingInfo((TLDBillRepayingModel repayingModel){
      if (mounted){
        setState(() {
          _isLoading = false;
          _repayingModel = repayingModel;
        });
      }
    }, (TLDError error){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }


  void _clearUser(){
     setState(() {
      _isLoading = true;
    });
    _modelManager.clearUser((){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '清退票据成功');
      Navigator.of(context).pop();
    }, (TLDError error){
      if (mounted){
        setState(() {
          _isLoading = false;
        });
      }
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
        heroTag: 'rank_tab_page',
        transitionBetweenRoutes: false,
        middle: Text('票据清退'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _repayingModel != null ? _getBodyWidget() : Container()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    return ListView.builder(
      itemCount: _repayingModel.list.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
          return TLDAAAPlusStarNoticeCell(noticeCotent: '票据功能将关闭，您的收益将会自动转入余利宝。',);
        }else if (index < _repayingModel.list.length + 1){
          TLDBillRepayingSonModel sonModel = _repayingModel.list[index - 1];
          return Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(2),left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30)),
            child: TLDClipCommonCell(
              type: TLDClipCommonCellType.normal,
              title: sonModel.content,
              titleStyle: TextStyle(color :Color.fromARGB(255, 153, 153, 153),fontSize:ScreenUtil().setSp(28)),
              content: sonModel.value,
              contentStyle: TextStyle(color :Color.fromARGB(255, 51, 51, 51),fontSize:ScreenUtil().setSp(28)),
            ),  
          );
        }else {
          return TLDBillRepayingBottomCell(
            repayingModel: _repayingModel,
            didClickClearButton: (){
              _clearUser();
            },
          );
        }
     },
    );
  }

}