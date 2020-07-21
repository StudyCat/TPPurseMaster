import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Model/tld_acceptance_earnings_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Page/tld_acceptance_invitation_detail_earning_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_open_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_search_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Invitation/View/tld_acceptance_invitation_earnings_unopen_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDAcceptanceInvitationEarningsPage extends StatefulWidget {
  TLDAcceptanceInvitationEarningsPage({Key key}) : super(key: key);

  @override
  _TLDAcceptanceInvitationEarningsPageState createState() => _TLDAcceptanceInvitationEarningsPageState();
}

class _TLDAcceptanceInvitationEarningsPageState extends State<TLDAcceptanceInvitationEarningsPage> {
  TLDAcceptanceEarningsModelManager _modelManager;

  bool _isLoading = true;

  List _dataSource = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _modelManager = TLDAcceptanceEarningsModelManager();
    _getInviteTeamInfo();
  }

  void _getInviteTeamInfo(){
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.getInviteTeamInfo((List result){
      _dataSource = [];
      if (mounted){
        setState(() {
          _isLoading = false;
          _dataSource.addAll(result);
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

  void _searchTel(String tel){
    if(mounted){
      setState(() {
        _isLoading = true;
      });
    }
    _modelManager.searchInviteUserInfo(tel,(List result){
      _dataSource = [];
      if (mounted){
        setState(() {
          _isLoading = false;
          _dataSource.addAll(result);
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

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(isLoading: _isLoading,child: _getListView(),);
  }

  Widget _getListView(){
    return ListView.builder(
      itemCount: _dataSource.length + 1,
      itemBuilder: (BuildContext context, int index) {
      if (index == 0){
        return TLDAcceptanceInvitationEarningsSearchCell(
          didClickSearchCallBack: (String tel){
            _searchTel(tel);
          },
        );
      }else{
        TLDInviteTeamModel teamModel = _dataSource[index - 1];
        if (teamModel.isOpen){
          return TLDAcceptanceInvitationOpenCell(
          inviteTeamModel: teamModel,
          didClickItemCallBack: (String userName){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDAcceptanceInvitationDetailEarningPage(userName: userName,)));
          },
          didClickOpenItem: (){
            setState(() {
              teamModel.isOpen = !teamModel.isOpen;
            });
          },
        );
        }else{
           return TLDAcceptanceInvitationEarningsUnopenCell(
             inviteTeamModel: teamModel,
             didClickOpenItem: (){
                setState(() {
                 teamModel.isOpen = !teamModel.isOpen;
              });
             },
           );
        }
      }
     },
    );
  }
}