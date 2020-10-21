import 'dart:io';

import 'package:dragon_sword_purse/Exchange/FirstPage/Page/tld_exchange_choose_wallet.dart';
import 'package:dragon_sword_purse/Find/YLB/Model/tld_ylb_choose_type_model_manager.dart';
import 'package:dragon_sword_purse/Find/YLB/Page/tld_ylb_choose_type_page.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TLDAAAPlusStarActionSheet extends StatefulWidget {
  TLDAAAPlusStarActionSheet({Key key}) : super(key: key);

  @override
  _TLDAAAPlusStarActionSheetState createState() => _TLDAAAPlusStarActionSheetState();
}

class _TLDAAAPlusStarActionSheetState extends State<TLDAAAPlusStarActionSheet> with WidgetsBindingObserver  {
   int _paymentType = 1;

   String _walletAddress;

   TLDYLBTypeModel _typeModel;

   FocusNode _focusNode;

   bool isKeyboardActived = false;

   TextEditingController _textEditingController;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _focusNode = FocusNode();

    _textEditingController = TextEditingController();

    // 监听输入框焦点变化
    _focusNode.addListener(_onFocus);
    // 创建一个界面变化的观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 当前是安卓系统并且在焦点聚焦的情况下
      if (Platform.isAndroid && _focusNode.hasFocus) {
        if (isKeyboardActived) {
          isKeyboardActived = false;
          // 使输入框失去焦点
          _focusNode.unfocus();
          return;
        }
        isKeyboardActived = true;
      }
    });
  }

   // 焦点变化时触发的函数
  void _onFocus() {
    if (_focusNode.hasFocus) {
      
      return;
    }
    
    // 失去焦点时候的操作
    isKeyboardActived = false;

  }

   // 既然有监听当然也要有卸载，防止内存泄漏嘛
  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    String content = "";
    if (_paymentType == 1){
      content = _walletAddress == null ? '请选择钱包' : _walletAddress;
    }else{
      content = _typeModel == null ? '请选择支付方式' : _typeModel.typeName;
    }
    return AnimatedPadding(
        //showModalBottomSheet 键盘弹出时自适应
        padding: MediaQuery.of(context).viewInsets, //边距（必要）
        duration: const Duration(milliseconds: 100), //时常 （必要）
        child: Container(
            // height: 180,
            constraints: BoxConstraints(
              minHeight: 90, //设置最小高度（必要）
              maxHeight: MediaQuery.of(context).size.height, //设置最大高度（必要）
            ),
            padding: EdgeInsets.only(top: 0, bottom: 0),
            child: ListView(shrinkWrap: true, //防止状态溢出 自适应大小
                children: <Widget>[
                  Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: <Widget>[
                    Container(
                      color: Color.fromARGB(255, 242, 242, 242),
                      height: ScreenUtil().setHeight(80),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text('升级',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                color: Color.fromARGB(255, 51, 51, 51))),
                      ),
                    ),
                    Padding(
                      padding : EdgeInsets.only(top : ScreenUtil().setHeight(20)),
                      child: _getInputWidget(),
                    ),
                    _getTitleWidget('选择支付方式'),
                    _getChoosePaymentTypeWidget(),
                    GestureDetector(
                      onTap: () {
                        if (_paymentType == 1){
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TLDEchangeChooseWalletPage(
                                      didChooseWalletCallBack:
                                          (TLDWalletInfoModel infoModel) {
                                        setState(() {
                                          _walletAddress =
                                              infoModel.walletAddress;
                                        });
                                      },
                                    )));
                        }else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TLDYLBChooseTypePage(
                                      didChooseTypeCallBack:
                                          (TLDYLBTypeModel typeModel) {
                                        setState(() {
                                          _typeModel =
                                              typeModel;
                                        });
                                      },
                                    )));
                        }
                      },
                      child: _walletAddressWidget(
                          content),
                    ),
                    _bottomWidget()
                  ])
                ])));
  }

    

   Widget _walletAddressWidget(String content) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(30)),
      child: Container(
          width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _paymentType == 1 ?  '支付钱包' :  '余利宝支付方式',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 51, 51, 51)),
              ),
              Row(children: <Widget>[
                Container(
                    width: ScreenUtil().setWidth(280),
                    child: Text(
                      content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 153, 153, 153)),
                    )),
                Icon(Icons.keyboard_arrow_right)
              ])
            ],
          )),
    );
  }

  Widget _getInputWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding : EdgeInsets.only(left : ScreenUtil().setWidth(30),),
          child : Text('数量',style : TextStyle(fontSize: ScreenUtil().setSp(28),color: Color.fromARGB(255, 51, 51, 51)))
        ),
        Padding(
          padding : EdgeInsets.only(right:ScreenUtil().setWidth(30)),
          child: Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(400),
            decoration: BoxDecoration(
              color : Color.fromARGB(255, 242, 242, 242),
              borderRadius: BorderRadius.all(Radius.circular(4))
            ),
            child: CupertinoTextField(
              focusNode: _focusNode,
              textInputAction: TextInputAction.done,
              decoration: BoxDecoration(
                border : Border.all(color :Color.fromARGB(0, 0, 0, 0))
              ),
              onChanged: (String text){
                
              },
            ),
          ),
        )
      ],
    );
  }

  
  Widget _getTitleWidget(String title) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40),left : ScreenUtil().setWidth(30)),
      child: Text(title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 51, 51, 51))),
    );
  }

   Widget _getChoosePaymentTypeWidget() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(30), left: ScreenUtil().setWidth(30)),
      child: Row(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
            child: _getSingleChoiceWidget(
              1,
              '钱包支付'
            )),
        Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: _getSingleChoiceWidget(
              2,
              '余利宝支付'
            ))
      ]),
    );
   }



  Widget _getSingleChoiceWidget(int type, String title) {
    return Row(children: <Widget>[
      Container(
        height: ScreenUtil().setHeight(18),
        width: ScreenUtil().setHeight(18),
        child: Radio(
          activeColor: Color.fromARGB(255, 51, 51, 51),
          focusColor: Color.fromARGB(255, 51, 51, 51),
          hoverColor: Color.fromARGB(255, 51, 51, 51),
          value: type,
          groupValue: _paymentType,
          onChanged: (value) {
            setState(() {
                _paymentType = value;
            });
          },
        ),
      ),
      Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
          child: GestureDetector(
              onTap: () {
                setState(() {
                _paymentType = type;
            });
              },
              child: Text(
                title,
                style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: ScreenUtil().setSp(24)),
              )))
    ]);
  }

   Widget _bottomWidget() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      child: Container(
        height: ScreenUtil().setHeight(80),
        color: Color.fromARGB(255, 242, 242, 242),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              child: RichText(
                text: TextSpan(
                    text: '20',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(48),
                        color: Color.fromARGB(255, 74, 74, 74),
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: 'TLD',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromARGB(255, 155, 155, 155),
                          ))
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Container(
                height: ScreenUtil().setHeight(80),
                width: ScreenUtil().setWidth(260),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).hintColor,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  child: Text('确认升级',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Color.fromARGB(255, 51, 51, 51),
                      )),
                  onPressed: () {
                    if (_paymentType == 1 && _walletAddress == null) {
                      Fluttertoast.showToast(msg: '请先选择钱包');
                      return;
                    }
                    if (_paymentType == 2 && _typeModel == null){
                      Fluttertoast.showToast(msg: '请先选择余利宝支付方式');
                      return;
                    }
                    String walletAddress =  _walletAddress == null ? '' : _walletAddress;
                    int ylbType = _typeModel == null ? 0 : _typeModel.type;
                    
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}