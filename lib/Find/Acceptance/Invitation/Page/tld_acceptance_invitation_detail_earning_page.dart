import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Model/tld_acceptance_invitation_detail_earning_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_detail_earning_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_detail_earning_header_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDAcceptanceInvitationDetailEarningPage extends StatefulWidget {
  TLDAcceptanceInvitationDetailEarningPage({Key key,this.userName}) : super(key: key);

  final String userName;

  @override
  _TLDAcceptanceInvitationDetailEarningPageState createState() => _TLDAcceptanceInvitationDetailEarningPageState();
}

class _TLDAcceptanceInvitationDetailEarningPageState extends State<TLDAcceptanceInvitationDetailEarningPage> {

  TLDAcceptanceInvitationDetailEarningModelManager _modelManager;

  bool _isLoading = true;

  TLDInviteDetailEarningModel _detailEarningModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDAcceptanceInvitationDetailEarningModelManager();
    _getDetailInfo();
  }

  void _getDetailInfo(){
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.getDetailEarningInfo(widget.userName, (TLDInviteDetailEarningModel detailEarningModel){
     if(mounted){
      setState(() {
        _isLoading = false;
        _detailEarningModel = detailEarningModel;
      });
    } 
    }, (TLDError error){
      if(mounted){
      setState(() {
        _isLoading = false;
      });
    } 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'detail_earning_page',
        transitionBetweenRoutes: false,
        middle: Text('收益详情'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _isLoading, child: _getBodyWidget()),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    if (_detailEarningModel != null){
      return ListView.builder(
      itemCount: _detailEarningModel.list.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if(index == 0){
          return TLDAcceptanceInvitationDetailHeaderCell(detailEarningModel: _detailEarningModel,);
        }else if(index == _detailEarningModel.list.length + 1){
          return _getBottomCell();
        }else{
          TLDEarningBillModel earningBillModel = _detailEarningModel.list[index - 1];
          return TLDAcceptanceInvitationDetailEarningCell(earningBillModel: earningBillModel,);
        }
     },
    );
    }else{
      return Container();
    }
  }


  Widget _getBottomCell(){
    return Padding(
       padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(20)),
       child: Container(
         decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white
         ),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(88),
        padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(20), 0, ScreenUtil().setHeight(20)),
        child: Row(
          children: <Widget>[
            Text('推广收益总计',style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51)),),
        Text('${_detailEarningModel.totalProfit}TLD',style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: Color.fromARGB(255, 153, 153, 153)),textAlign: TextAlign.end,)
          ],
        ),
       ),
    );
  }

}