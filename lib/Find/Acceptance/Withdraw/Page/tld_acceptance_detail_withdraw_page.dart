import 'dart:async';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonFunction/tld_common_function.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_clip_common_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_detail_withdraw_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_detail_withdraw_bottom_cell.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_detail_withdraw_header_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/View/tld_acceptance_withdraw_bottom_cell.dart';
import 'package:dragon_sword_purse/IMUI/Page/tld_im_page.dart';
import 'package:dragon_sword_purse/Message/Page/tld_just_notice_page.dart';
import 'package:dragon_sword_purse/Order/Page/tld_order_appeal_page.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_alipay_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_diy_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_order_paymethod_cell.dart';
import 'package:dragon_sword_purse/Order/View/tld_detail_wechat_qrcode_show_view.dart';
import 'package:dragon_sword_purse/Socket/tld_new_im_manager.dart';
import 'package:dragon_sword_purse/ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmessage_flutter/jmessage_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TLDAcceptanceDetailWithdrawPage extends StatefulWidget {
  TLDAcceptanceDetailWithdrawPage({Key key,this.cashNo}) : super(key: key);
 
  final String cashNo;

  @override
  _TLDAcceptanceDetailWithdrawPageState createState() => _TLDAcceptanceDetailWithdrawPageState();
}

class _TLDAcceptanceDetailWithdrawPageState extends State<TLDAcceptanceDetailWithdrawPage> {
  List referrerTitles = ['订单号', '数量', '应付款', '收款方式', '接收地址','买家',''];
  List platformTitles = ['订单号', '数量', '应付款', '收款方式', '接收地址','买家','手续费率','手续费',''];
  bool isOpen = false;
  StreamController _controller;
  bool _isLoading = false;
  // StreamSubscription _systemSubscreption;

  TLDAcceptanceDetailWithdrawModelManager _modelManager;

  TLDAcceptanceWithdrawOrderListModel _detailModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = StreamController();

    _modelManager = TLDAcceptanceDetailWithdrawModelManager();
    _getDetailInfo();

    _addSystemMessageCallBack();
    // _registerSystemEvent();
  }

  void _getDetailInfo(){
    if (mounted){
      setState(() {
        _isLoading = true;
    });
    }
    _modelManager.getDetailInfo(widget.cashNo, (TLDAcceptanceWithdrawOrderListModel detailModel){
      if (mounted){
      setState(() {
        _isLoading = false;
        _detailModel = detailModel;
    });
    }
    }, (TLDError error){
      if (mounted){
      setState(() {
        _isLoading = false;
    });
    Fluttertoast.showToast(msg: error.msg);
    }
    });
  }

    void _cancelWithdraw(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.cancelWithdraw(widget.cashNo, (){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '取消提现成功');
      _getDetailInfo();
    }, (TLDError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _surePay(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.withdrawSurePay(widget.cashNo, (){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '确认我已支付成功');
      _getDetailInfo();
    }, (TLDError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _sureSentTLD(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.sentWithdrawTLD(widget.cashNo, (){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '确认释放TLD成功');
      _getDetailInfo();
    }, (TLDError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void _reminder(){
    setState(() {
      _isLoading = true;
    });
    _modelManager.sentWithdrawTLD(widget.cashNo, (){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: '催单成功');
    }, (TLDError error){
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      Fluttertoast.showToast(msg: error.msg);
    });
  }

  void alertPassWord(Function function){
    jugeHavePassword(context, function, TLDCreatePursePageType.back, function);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    TLDNewIMManager().removeSystemMessageReceiveCallBack();
  }

     void _addSystemMessageCallBack(){
    TLDNewIMManager().addSystemMessageReceiveCallBack((dynamic message){
      JMNormalMessage normalMessage = message;
      Map extras = normalMessage.extras;
      int contentType = int.parse(extras['contentType']);
      if (contentType == 200 || contentType == 201 || contentType == 203 || contentType == 204){
        _getDetailInfo();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(isLoading:_isLoading, child: StreamBuilder(
        stream: _controller.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
            return  NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[_getAppBar()];
          },
          body: _getBodyWidget(context)
          );
        },
      )),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getAppBar() {
    return SliverAppBar(
      centerTitle: true, //标题居中
      expandedHeight: 200.0, //展开高度200
      backgroundColor: Theme.of(context).primaryColor,
      leading: Container(
        height: ScreenUtil().setHeight(34),
        width: ScreenUtil().setHeight(34),
        child: CupertinoButton(
          child: Icon(
            IconData(
              0xe600,
              fontFamily: 'appIconFonts',
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floating: true, //不随着滑动隐藏标题
      pinned: true, //不固定在顶部
      title: Text('订单详情'),
      flexibleSpace: FlexibleSpaceBar(
        background: TLDAcceptanceDetailWithdrawHeaderView(
          detailModel: _detailModel,
        didClickChatBtnCallBack: (){
          String toUserName = '';
          if (_detailModel.amApply){
            toUserName = _detailModel.inviteUserName;
          }else{
            toUserName = _detailModel.applyUserName;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(toUserName: toUserName,orderNo: '',))).then((value){
            _getDetailInfo();
          });
        },
        timeIsOverRefreshUICallBack: (){
          _getDetailInfo();
        },didClickAppealBtnCallBack: (){
         _jumpToOrderAppeal();
        },
        ),
      ),
    );
  }

  void _jumpToOrderAppeal(){
     if (_detailModel.appealStatus == -1) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDOrderAppealPage(detailWithDrawModel: _detailModel,))).then((value) => _getDetailInfo());
          }else{
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDJustNoticePage(appealId: _detailModel.appealId,type: TLDJustNoticePageType.appealWatching,))).then((value) => _getDetailInfo());
          }
  }

  Widget _getBodyWidget(BuildContext context) {
    if (_detailModel == null){
      return Container();
    }else{
      bool isNeedAppeal = false;
      String appealTitle = '';
      _getAppealStatusAndAppealTitle((bool isNeed, String title){
        isNeedAppeal = isNeed;
        appealTitle = title;
      });
      List titles = _detailModel.cashType == 1 ? referrerTitles : platformTitles;
      return ListView.builder(
        itemCount: isNeedAppeal ? titles.length + 2 : titles.length + 1,
        itemBuilder: (BuildContext context, int index) {
          num top;
          if (index == 2) {
            top = ScreenUtil().setHeight(20);
          } else {
            top = ScreenUtil().setHeight(2);
          }
          if (index == 3) {
            return Padding(
              padding: EdgeInsets.only(
                  top: top,
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30)),
              child: TLDDetailOrderPayMethodCell(
                title: titles[index],
                titleStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    color: Color.fromARGB(255, 51, 51, 51)),
                isOpen: isOpen,
                paymentModel: _detailModel.payMethodVO,
                didClickCallBack: (){
                  setState(() {
                    isOpen = !isOpen;
                  });
                  if (_detailModel.payMethodVO.type == 2 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailWechatQrCodeShowView(qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,));
                  }else if (_detailModel.payMethodVO.type == 3 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailAlipayQrCodeShowView(qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,));                    
                  }else if (_detailModel.payMethodVO.type == 4 && isOpen == true){
                    if (_detailModel.payMethodVO.imageUrl.length > 0) {
                      showDialog(context: context,builder: (context) => TLDDetailDiyQrcodeShowView(paymentName: _detailModel.payMethodVO.myPayName,qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,)); 
                    }else{
                      // Fluttertoast.showToast(msg: '未设置二维码');
                    }
                  }
                },
                didClickQrCodeCallBack: (){
                  if (_detailModel.payMethodVO.type == 2 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailWechatQrCodeShowView(qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,));
                  }else if (_detailModel.payMethodVO.type == 3 && isOpen == true){
                      showDialog(context: context,builder: (context) => TLDDetailAlipayQrCodeShowView(qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,));                    
                  }else if (_detailModel.payMethodVO.type == 4 && isOpen == true){
                    if (_detailModel.payMethodVO.imageUrl.length > 0) {
                      showDialog(context: context,builder: (context) => TLDDetailDiyQrcodeShowView(paymentName: _detailModel.payMethodVO.myPayName,qrCode: _detailModel.payMethodVO.imageUrl,amount: _detailModel.cashPrice,)); 
                    }else{
                      Fluttertoast.showToast(msg: '自定义支付方式未设置二维码');
                    }
                  }
                },
              ),
            );
          }else if(index == (isNeedAppeal ? titles.length + 1 : titles.length)){
            return TLDAcceptanceDetailWithdrawBottomCell(
              detailModel: _detailModel,
              didClickActionBtnCallBack: (String title){
                if (title == '我已付款') {
                  alertPassWord(_surePay);
                }else if(title == '取消提现'){
                  alertPassWord(_cancelWithdraw);
                }else if(title == '确认释放TLD'){
                  alertPassWord(_sureSentTLD);
                }else if (title == '催单'){
                  _reminder();
                }
              },
              );
          }else if (index == titles.length - 1){
            return _getIMCell();
          }else {
            if (isNeedAppeal) {
              if (index == titles.length) {
                return _getAppealCell(appealTitle);
              }else{
                return _getNormalCell(context, top, index, titles);
              }
            }else{
              return _getNormalCell(context, top, index, titles);
            }
          }
        });
    }
  }

  void _getAppealStatusAndAppealTitle(Function(bool,String) callBack){
     bool isNeedAppeal = false;
     String appealTitle = '';
    if (_detailModel != null){
      switch (_detailModel.cashStatus) {
        case 1 :{
          isNeedAppeal = true;
          appealTitle = '订单申诉';
        }
        break;
        default :{         
        }
        break;
        }
      }
    if (_detailModel.appealStatus > -1){
      isNeedAppeal = true;
      if (_detailModel.appealStatus == 0) {
        appealTitle = '订单申诉中';
      }else if(_detailModel.appealStatus == 1){
        appealTitle = '订单申诉成功';
      }else if(_detailModel.appealStatus == 2){
        appealTitle = '订单申诉失败';
      }else {
        appealTitle = '订单申诉';
      }
    }
    callBack(isNeedAppeal,appealTitle);
  }

  Widget _getNormalCell(BuildContext context, num top, int index,List titles) {
    String content = '';
    if(index == 0){
      content = _detailModel.cashNo;
    }else if(index == 1){
      content = _detailModel.tldCount + 'TLD';
    }else if(index == 2){
      content = '¥'+_detailModel.cashPrice;
    }else if(index == 4){
      content = _detailModel.inviteWalletAddress;
    }else if(index == 5){
      content = _detailModel.cashType == 1 ? '推荐人' : '买家';
    }else if(index == 6){
      double rate = double.parse(_detailModel.chargeRate) * 100;
      content = '${rate}%';
    }else if(index == 7){
      content = '${_detailModel.chargeValue}TLD';
    }
    return Padding(
      padding: EdgeInsets.only(
          top: top,
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TLDClipCommonCell(
          type: TLDClipCommonCellType.normal,
          title: titles[index],
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: content,
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    );
  }


  Widget _getIMCell(){
    String title;
    if (_detailModel.cashType == 1) {
      title = _detailModel.amApply == true ? '联系推荐人' : '联系提现人';
    }else{
      title = _detailModel.amApply == true ? '联系平台客服' : '联系提现人';
    }
    return GestureDetector(
      onTap: () { 
        String toUserName = '';
           if (_detailModel.amApply){
            toUserName = _detailModel.inviteUserName;
          }else{
            toUserName = _detailModel.applyUserName;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage(toUserName: toUserName,orderNo: '',))).then((value){
            _getDetailInfo();
          });
      },
      child:  Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(2),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TLDClipCommonCell(
          type: TLDClipCommonCellType.normalArrow,
          title: title,
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: '',
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    ),
    );
  }

  Widget _getAppealCell(String appealTitle){
    return GestureDetector(
      onTap: () {
        _jumpToOrderAppeal();
      },
      child:  Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(2),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        child: TLDClipCommonCell(
          type: TLDClipCommonCellType.normalArrow,
          title: appealTitle,
          titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 51, 51, 51)),
          content: '',
          contentStyle: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 102, 102, 102)),
        ),
      ),
    ),
    );
  }
}