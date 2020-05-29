
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import '../../CommonWidget/tld_data_manager.dart';
import 'dart:convert';

class TLDOrderListModel {
  int orderId;
  String orderNo;
  String buyerAddress;
  String sellerAddress;
  Null tmpWalletAddress;
  String payMethod;
  int status;
  String txCount;
  int createTime;
  int payTime;
  int finishTime;
  int expireTime;
  bool overtime;
  String remarkPayNo;

  TLDOrderListModel(
      {this.orderId,
      this.orderNo,
      this.buyerAddress,
      this.sellerAddress,
      this.tmpWalletAddress,
      this.payMethod,
      this.status,
      this.txCount,
      this.createTime,
      this.payTime,
      this.finishTime,
      this.expireTime,
      this.overtime,
      this.remarkPayNo});

  TLDOrderListModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    buyerAddress = json['buyerAddress'];
    sellerAddress = json['sellerAddress'];
    tmpWalletAddress = json['tmpWalletAddress'];
    payMethod = json['payMethod'];
    status = json['status'];
    txCount = json['txCount'];
    createTime = json['createTime'];
    payTime = json['payTime'];
    finishTime = json['finishTime'];
    expireTime = json['expireTime'];
    overtime = json['overtime'];
    remarkPayNo = json['remarkPayNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['buyerAddress'] = this.buyerAddress;
    data['sellerAddress'] = this.sellerAddress;
    data['tmpWalletAddress'] = this.tmpWalletAddress;
    data['payMethod'] = this.payMethod;
    data['status'] = this.status;
    data['txCount'] = this.txCount;
    data['createTime'] = this.createTime;
    data['payTime'] = this.payTime;
    data['finishTime'] = this.finishTime;
    data['expireTime'] = this.expireTime;
    data['overtime'] = this.overtime;
    data['remarkPayNo'] = this.remarkPayNo;
    return data;
  }
}

class TLDOrderListPramaterModel{
  int type;
  int page;
  int status;
}


class TLDOrderListModelManager{
  void getOrderList(TLDOrderListPramaterModel pramaterModel,Function(List) success,Function(TLDError) failure){
    List purseList = TLDDataManager.instance.purseList;
      List addressList = [];
      for (TLDWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
    Map pramater = {'type': pramaterModel.type,'pageNo':pramaterModel.page,'pageSize':10,'walletAddressList':addressListJson};
    if(pramaterModel.status != null){
      pramater.addAll({'status':pramaterModel.status});
    }
    TLDBaseRequest request = TLDBaseRequest(pramater,'order/list');
    request.postNetRequest((dynamic value) {
      Map dataMap = value;
      List dataList = dataMap['list'];
      List result = [];
      for (Map item in dataList) {
        TLDOrderListModel model = TLDOrderListModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (TLDError error){
        failure(error);
    });
  }
}