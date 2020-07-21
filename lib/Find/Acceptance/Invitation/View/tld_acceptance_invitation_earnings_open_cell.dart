import 'package:dragon_sword_purse/Find/Acceptance/Invitation/Model/tld_acceptance_earnings_model_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAcceptanceInvitationOpenCell extends StatefulWidget {
  TLDAcceptanceInvitationOpenCell({Key key,this.didClickItemCallBack,this.didClickOpenItem,this.inviteTeamModel}) : super(key: key);

  final Function(String) didClickItemCallBack;

  final Function didClickOpenItem;

  final TLDInviteTeamModel inviteTeamModel;

  @override
  _TLDAcceptanceInvitationOpenCellState createState() =>
      _TLDAcceptanceInvitationOpenCellState();
}

class _TLDAcceptanceInvitationOpenCellState
    extends State<TLDAcceptanceInvitationOpenCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(20)),
      child: Container(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  top: ScreenUtil().setHeight(20)),
              child: _getHeaderRowView(),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: Divider(
                height: ScreenUtil().setHeight(2),
                color: Color.fromARGB(255, 219, 218, 216),
              ),
            ),
           Padding(padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  top: ScreenUtil().setHeight(20)),
                  child: _getGridView(),),
           GestureDetector(
             onTap:widget.didClickOpenItem,
             child : Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.black,
              ),
            )
           )
          ],
        ),
      ),
    );
  }

  Widget _getGridView() {
    return GridView.builder(
        physics: new NeverScrollableScrollPhysics(), //增加
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2,
            crossAxisSpacing: ScreenUtil().setWidth(10),
            mainAxisSpacing: ScreenUtil().setHeight(10)),
        itemCount: widget.inviteTeamModel.userList.length,
        itemBuilder: (context, index) {
          String userName = widget.inviteTeamModel.userList[index];
          return GestureDetector(
            onTap :() => widget.didClickItemCallBack(userName),
            child :_getGridItem(index)
          );
        });
  }

  Widget _getGridItem(int index){
    String userName = widget.inviteTeamModel.userList[index];
    return Container(
      height : ScreenUtil().setHeight(72),
       decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Theme.of(context).hintColor),
        child: Center(
          child: Text(userName,style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 143, 110, 68)),
        ),
        )
    );
  }

  Widget _getHeaderRowView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '${widget.inviteTeamModel.level}级推广团队(${widget.inviteTeamModel.totalUserCount}人)',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Color.fromARGB(255, 51, 51, 51)),
        ),
        Column(
          children: <Widget>[
            Text(
              '${widget.inviteTeamModel.totalProfit}TLD',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
            Text(
              '总收益',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 153, 153, 153)),
              textAlign: TextAlign.end,
            ),
          ],
        )
      ],
    );
  }
}
