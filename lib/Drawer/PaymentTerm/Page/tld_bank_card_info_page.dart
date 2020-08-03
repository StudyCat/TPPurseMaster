import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../CommonWidget/tld_clip_title_input_cell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Model/tld_create_payment_model_manager.dart';


class TLDBankCardInfoPage extends StatefulWidget {
  TLDBankCardInfoPage({Key key,this.walletAddress,this.paymentModel}) : super(key: key);

  final String walletAddress;

  final TLDPaymentModel paymentModel;
  @override
  _TLDBankCardInfoPageState createState() => _TLDBankCardInfoPageState();
}

class _TLDBankCardInfoPageState extends State<TLDBankCardInfoPage> {
  
  TLDCreatePaymentPramaterModel _pramaterModel;

  TLDCreatePaymentModelManager _manager;

  bool _loading;

  List titles = [
    '真实姓名',
    '银行卡号',
    '开户行',
    '限额（每日）'
  ];

  List placeholders = [
    '请输入您的真实姓名',
    '请输入您的银行卡号',
    '请输入开户行',
    '请输入您的限制额度'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _loading = false;

    _pramaterModel = TLDCreatePaymentPramaterModel();
    _pramaterModel.type = 1;
    _pramaterModel.walletAddress = widget.walletAddress;

    if(widget.paymentModel != null){
      _pramaterModel.payId = widget.paymentModel.payId.toString();
      _pramaterModel.subBranch = widget.paymentModel.subBranch;
      _pramaterModel.account = widget.paymentModel.account;
      _pramaterModel.realName = widget.paymentModel.realName;
      _pramaterModel.quota = widget.paymentModel.quota;
    }

    _manager = TLDCreatePaymentModelManager();


  }

  void createBankPayment(){
    if(_pramaterModel.realName.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写真实姓名",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.account.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写银行卡号",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.subBranch.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写开户行",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.quota.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写每日最低购买额度",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    setState(() {
      _loading = true;
    });
    _manager.createPayment(_pramaterModel, (){
      if (mounted){
        setState(() {
          _loading = false;
        });
      }
      Fluttertoast.showToast(
                      msg: "添加银行卡成功",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TLDError error){
      if (mounted){
       setState(() {
        _loading = false;
      });
      }
    });
  }

  void updateBankInfo(){
    if(_pramaterModel.realName.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写真实姓名",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.account.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写银行卡号",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.subBranch.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写开户行",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    if(_pramaterModel.quota.length == 0){
      Fluttertoast.showToast(
                      msg: "请填写每日限额",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
                      return;
    }
    setState(() {
      _loading = true;
    });
    _manager.updatePayment(_pramaterModel, (){
      if(mounted){
      setState(() {
        _loading = false;
      });
      }
      Fluttertoast.showToast(
                      msg: "修改银行卡成功",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1);
      Navigator.of(context).pop();
    }, (TLDError error){
      if (mounted){
       setState(() {
        _loading = false;
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'bank_card_info_page',
        transitionBetweenRoutes: false,
        middle: Text('银行卡账号信息'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: LoadingOverlay(isLoading: _loading, child: _getBodyWidget(context)),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

   Widget _getBodyWidget(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: titles.length + 1,
      itemBuilder: (BuildContext context, int index){
        if (index < titles.length) {
          String content;
          if(index == 0){
            content = _pramaterModel.realName;
          }else if(index == 1){
            content = _pramaterModel.account;
          }else if(index == 2){
            content = _pramaterModel.subBranch;
          }else if(index == 3){
            content = _pramaterModel.quota;
          }
          return Padding(
          padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
          child: TLDClipTitleInputCell(content: content,title : titles[index],placeholder: placeholders[index],textFieldEditingCallBack: (String string){
          if(index == 0){
            _pramaterModel.realName = string;
          }else if(index == 1){
            _pramaterModel.account = string;
          }else if(index == 2){
            _pramaterModel.subBranch = string;
          }else if(index == 3){
            _pramaterModel.quota = string;
          }
        },),
        );
        }else{
          return Column(
            children :<Widget>[
              Padding(padding: EdgeInsets.only(top:ScreenUtil().setHeight(2),left: ScreenUtil().setWidth(30),right: ScreenUtil().setWidth(30)),
              child : Container(
                decoration: BoxDecoration(
                  borderRadius : BorderRadius.all(Radius.circular(4)),
                  color : Colors.white
                ),
                padding:  EdgeInsets.only(top:ScreenUtil().setHeight(20),left: ScreenUtil().setWidth(20),right: ScreenUtil().setWidth(20),bottom: ScreenUtil().setHeight(20)),
                width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
                child: Text('声明：\n请认真填写您的收款方式，如填写无效的或者错误的收款方式，导致的资产损失，平台概不负责。',style: TextStyle(
                  fontSize : ScreenUtil().setSp(24),
                  color: Color.fromARGB(255, 51, 51, 51)
                ),),
              ),
              ),
              Container(
            margin : EdgeInsets.only(top : ScreenUtil().setHeight(400),left: ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100)),
            height: ScreenUtil().setHeight(80),
            width:size.width -  ScreenUtil().setWidth(200),
            child: CupertinoButton(child: Text('保存',style: TextStyle(fontSize : ScreenUtil().setSp(28),color : Colors.white),),padding: EdgeInsets.all(0), color: Theme.of(context).primaryColor,onPressed: (){ 
              if(_pramaterModel.payId.length == 0){
                createBankPayment();
              }else{
                updateBankInfo();
              }
            }),
            )
            ]
          ); 
        }
      }
    );
  }
}