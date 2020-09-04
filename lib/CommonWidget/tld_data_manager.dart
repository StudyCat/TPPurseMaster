import 'dart:convert';

import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';
import 'package:dragon_sword_purse/generated/i18n.dart';
import 'package:dragon_sword_purse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TLDOrderStatusInfoModel{
  String orderStatusName;
  Color orderStatusColor;
  List buyerActionButtonTitle;
  List sellerActionButtonTitle;
  TLDOrderStatusInfoModel({this.orderStatusName,this.orderStatusColor,this.buyerActionButtonTitle,this.sellerActionButtonTitle});
}

class TLDDataManager{
  // 工厂模式
  factory TLDDataManager() =>_getInstance();
  static TLDDataManager get instance => _getInstance();
  static TLDDataManager _instance;

  String password;

  Locale currentLocal;  

  List purseList;

  String lastLink;

  String acceptanceToken;

  String registrationID = '';

  String userToken;

  String username; //IM的username

  String missionWalletAddress;

  List webList;

  TLDDataManager._internal() {
    // 初始化
   getPassword();

   getUserToken();

   getUserName();

   getMissionWalletAddress();

   getAcceptanceToken();
  }


  Future<String>  getPassword()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    password = pre.getString('password');
    return password;
  } 

  Future<String> getUserToken()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    userToken = pre.getString('userToken');
    return userToken;
  }


  Future<String> getUserName()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    username = pre.getString('username');
    return username;
  }


  Future<List> get3rdPartWebList()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    String webListStr = pre.getString('3rdPartWeb');
    webList = [];
    if (webListStr != null){
      List webJsonList = jsonDecode(webListStr);
      for (var item in webJsonList) {
        TLD3rdWebInfoModel webInfoModel = TLD3rdWebInfoModel.fromJson(item);
        webList.add(webInfoModel);
      }
      return webList;
    }
    return webList;
  }


  Future<String> getMissionWalletAddress()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    missionWalletAddress = pre.getString('missionWalletAddress');
    return missionWalletAddress;
  }

  Future<String> getAcceptanceToken()async{
     SharedPreferences pre = await SharedPreferences.getInstance();
    acceptanceToken = pre.getString('acceptanceToken');
    return acceptanceToken;
  }

  deleteAcceptanceToken()async{
     SharedPreferences pre = await SharedPreferences.getInstance();
    pre.remove('acceptanceToken');
    this.acceptanceToken = null;
  }



  static TLDDataManager _getInstance() {
    if (_instance == null) {
      _instance = new TLDDataManager._internal();
    }
    return _instance;
  }

  // 获取订单每个状态的展示，key为订单状态
  static Map get orderListStatusMap{
      return {
        -1 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).canceledStatusLabel,orderStatusColor: Color.fromARGB(255, 153, 153, 153),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        0 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).waitPayLabel,orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: [I18n.of(navigatorKey.currentContext).cancelOrderBtnTitle,I18n.of(navigatorKey.currentContext).surePaymentBtnTitle],sellerActionButtonTitle: []),
        1 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).havePaidLabel,orderStatusColor: Color.fromARGB(255, 22, 128, 205),buyerActionButtonTitle: [I18n.of(navigatorKey.currentContext).reminderBtnTitle],sellerActionButtonTitle: [I18n.of(navigatorKey.currentContext).sureReleaseTLDBtnTitle]),
        2 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).finishedStatusLabel,orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        3 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).overtimeLabel,orderStatusColor: Color.fromARGB(255, 208, 2, 27),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        4 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).appealingLabel,orderStatusColor: Color.fromARGB(255, 239, 130, 31),buyerActionButtonTitle: [],sellerActionButtonTitle: [])
      };
  }

  static Map get iMOrderListStatusMap{
    return {
        -1 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).canceledStatusLabel,orderStatusColor: Color.fromARGB(255, 153, 153, 153),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        0 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).waitPayLabel,orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: [I18n.of(navigatorKey.currentContext).surePaymentBtnTitle],sellerActionButtonTitle: []),
        1 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).havePaidLabel,orderStatusColor: Color.fromARGB(255, 22, 128, 205),buyerActionButtonTitle: [I18n.of(navigatorKey.currentContext).reminderBtnTitle],sellerActionButtonTitle: [I18n.of(navigatorKey.currentContext).sureReleaseTLDBtnTitle]),
        2 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).finishedStatusLabel,orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        3 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).overtimeLabel,orderStatusColor: Color.fromARGB(255, 208, 2, 27),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        4 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).appealingLabel,orderStatusColor: Color.fromARGB(255, 239, 130, 31),buyerActionButtonTitle: [],sellerActionButtonTitle: [])
      };
  }

    static Map get acceptanceWithdrawOrderStatusMap{
    return {
        -1 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).canceledStatusLabel,orderStatusColor: Color.fromARGB(255, 153, 153, 153),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        0 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).waitPayLabel,orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: [I18n.of(navigatorKey.currentContext).iHavePaid],sellerActionButtonTitle: [I18n.of(navigatorKey.currentContext).cancelWithdraw]),
        1 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).havePaidLabel,orderStatusColor: Color.fromARGB(255, 22, 128, 205),buyerActionButtonTitle: [I18n.of(navigatorKey.currentContext).reminderBtnTitle],sellerActionButtonTitle: [I18n.of(navigatorKey.currentContext).sureReleaseTLDBtnTitle]),
        2 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).finishedStatusLabel,orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        3 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).overtimeLabel,orderStatusColor: Color.fromARGB(255, 208, 2, 27),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        4 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).appealingLabel,orderStatusColor: Color.fromARGB(255, 239, 130, 31),buyerActionButtonTitle: [],sellerActionButtonTitle: [])
      };
  }

    static Map get accptanceOrderListStatusMap{
    return {
        -1 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).profitPause,orderStatusColor: Color.fromARGB(255, 245, 166, 35),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        0 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).havingProfit,orderStatusColor: Color.fromARGB(255, 65, 117, 5),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        1 : TLDOrderStatusInfoModel(orderStatusName:I18n.of(navigatorKey.currentContext).haveExpired,orderStatusColor: Color.fromARGB(255, 153, 153, 153),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
      };
  }

}