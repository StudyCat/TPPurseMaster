
import 'package:dragon_sword_purse/Socket/tld_im_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_format/date_format.dart';

class TLDIMMessageCell extends StatefulWidget {
  TLDIMMessageCell({Key key,this.messageModel}) : super(key: key);

  final TLDMessageModel messageModel;

  @override
  _TLDIMMessageCellState createState() => _TLDIMMessageCellState();
}

class _TLDIMMessageCellState extends State<TLDIMMessageCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String content;
    if(widget.messageModel.contentType == 2){
      content = '[图片]';
    }else{
      content = widget.messageModel.content;
    }
    return Padding(
      padding: EdgeInsets.only(left : ScreenUtil().setWidth(30),right : ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(2)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: Container(
          color : Colors.white,
          height : ScreenUtil().setHeight(168),
          padding: EdgeInsets.only(left : ScreenUtil().setWidth(28),right: ScreenUtil().setWidth(28),top: ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getOrderNoWidget(),
              Container(
                width: size.width - ScreenUtil().setWidth(250),
                child: Text(content,style:TextStyle(fontSize : ScreenUtil().setSp(24),color: Color.fromARGB(255, 153, 153, 153)),maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,),
              ),
              _getTimeAndStatusWidget()
            ],
          ),
        ),
      ),
      );
  }


  Widget _getOrderNoWidget(){
    String unreadCount = '';
    if(widget.messageModel.unreadCount > 99){
      unreadCount = '99+';
    }else{
      unreadCount = '${widget.messageModel.unreadCount}';
    }
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('订单号：'+ widget.messageModel.orderNo,style : TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 51, 51, 51))),
          Offstage(
            offstage : !widget.messageModel.unread,
            child: Container(
              width:ScreenUtil().setWidth(40),
              height : ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                color : Color.fromARGB(255, 208, 2, 27),
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))
              ),
              child: Center(child :Text(unreadCount,style : TextStyle(fontSize : ScreenUtil().setSp(20),color : Colors.white))),
            ),
          )
        ],
      )
    );
  }

  Widget _getTimeAndStatusWidget(){
    return Container(
      width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(100),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(formatDate(DateTime.fromMillisecondsSinceEpoch(widget.messageModel.createTime),[yyyy,'-',mm,'-',dd,' ',HH,':',nn,':',ss]),style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153)),),
          Text(widget.messageModel.unread ? '未读':'已读',style: TextStyle(fontSize : ScreenUtil().setSp(20),color : widget.messageModel.unread ? Color.fromARGB(255, 208, 2, 27):Color.fromARGB(255, 153, 153, 153))),
        ],
      )
    );
  }
}