import 'package:dragon_sword_purse/Order/Model/tld_order_list_model_manager.dart';
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

  List purseList;

  String registrationID = '';

  String userToken;

  TLDDataManager._internal() {
    // 初始化
   getPassword();

   getUserToken();
  }


  Future<String>  getPassword()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    password = pre.getString('password');
  } 

  Future<String> getUserToken()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    userToken = pre.getString('userToken');
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
        -1 : TLDOrderStatusInfoModel(orderStatusName:'已取消',orderStatusColor: Color.fromARGB(255, 153, 153, 153),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        0 : TLDOrderStatusInfoModel(orderStatusName:'待支付',orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: ['取消订单','我已付款'],sellerActionButtonTitle: []),
        1 : TLDOrderStatusInfoModel(orderStatusName:'已支付',orderStatusColor: Color.fromARGB(255, 22, 128, 205),buyerActionButtonTitle: ['催单'],sellerActionButtonTitle: ['确认释放积分']),
        2 : TLDOrderStatusInfoModel(orderStatusName:'已完成',orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        3 : TLDOrderStatusInfoModel(orderStatusName:'已超时',orderStatusColor: Color.fromARGB(255, 208, 2, 27),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        4 : TLDOrderStatusInfoModel(orderStatusName:'申诉中',orderStatusColor: Color.fromARGB(255, 239, 130, 31),buyerActionButtonTitle: [],sellerActionButtonTitle: [])
      };
  }

  static Map get iMOrderListStatusMap{
    return {
        -1 : TLDOrderStatusInfoModel(orderStatusName:'已取消',orderStatusColor: Color.fromARGB(255, 153, 153, 153),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        0 : TLDOrderStatusInfoModel(orderStatusName:'待支付',orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: ['我已付款'],sellerActionButtonTitle: []),
        1 : TLDOrderStatusInfoModel(orderStatusName:'已支付',orderStatusColor: Color.fromARGB(255, 22, 128, 205),buyerActionButtonTitle: ['催单'],sellerActionButtonTitle: ['确认释放积分']),
        2 : TLDOrderStatusInfoModel(orderStatusName:'已完成',orderStatusColor: Color.fromARGB(255, 68, 149, 34),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        3 : TLDOrderStatusInfoModel(orderStatusName:'已超时',orderStatusColor: Color.fromARGB(255, 208, 2, 27),buyerActionButtonTitle: [],sellerActionButtonTitle: []),
        4 : TLDOrderStatusInfoModel(orderStatusName:'申诉中',orderStatusColor: Color.fromARGB(255, 239, 130, 31),buyerActionButtonTitle: [],sellerActionButtonTitle: [])
      };
  }

}