import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDDetailOrderModel {
  int finishTime;
  String orderNo;
  int orderId;
  int payTime;
  String sellerAddress;
  String remarkPayNo;
  String buyerAddress;
  int expireTime;
  int createTime;
  String payMethod;
  String tmpWalletAddress;
  String txCount;
  bool overtime;
  int status; //(-1：已取消，0：待支付，1：已支付，2：已完成，3：已超时)

  TLDDetailOrderModel(
      {this.finishTime,
      this.orderNo,
      this.orderId,
      this.payTime,
      this.sellerAddress,
      this.remarkPayNo,
      this.buyerAddress,
      this.expireTime,
      this.createTime,
      this.payMethod,
      this.tmpWalletAddress,
      this.txCount,
      this.overtime,
      this.status});

  TLDDetailOrderModel.fromJson(Map<String, dynamic> json) {
    finishTime = json['finishTime'];
    orderNo = json['orderNo'];
    orderId = json['orderId'];
    payTime = json['payTime'];
    sellerAddress = json['sellerAddress'];
    remarkPayNo = json['remarkPayNo'];
    buyerAddress = json['buyerAddress'];
    expireTime = json['expireTime'];
    createTime = json['createTime'];
    payMethod = json['payMethod'];
    tmpWalletAddress = json['tmpWalletAddress'];
    txCount = json['txCount'];
    overtime = json['overtime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finishTime'] = this.finishTime;
    data['orderNo'] = this.orderNo;
    data['orderId'] = this.orderId;
    data['payTime'] = this.payTime;
    data['sellerAddress'] = this.sellerAddress;
    data['remarkPayNo'] = this.remarkPayNo;
    data['buyerAddress'] = this.buyerAddress;
    data['expireTime'] = this.expireTime;
    data['createTime'] = this.createTime;
    data['payMethod'] = this.payMethod;
    data['tmpWalletAddress'] = this.tmpWalletAddress;
    data['txCount'] = this.txCount;
    data['overtime'] = this.overtime;
    data['status'] = this.status;
    return data;
  }
}

class TLDDetailOrderModelManager {
  void getDetailOrderInfoWithOrderNo(
      String orderNo, Function(TLDDetailOrderModel) success, Function failure) {
    TLDBaseRequest request =
        TLDBaseRequest({'orderNo': orderNo}, 'order/detail');
    request.postNetRequest((dynamic value) {
      Map data = value;
      TLDDetailOrderModel detailModel = TLDDetailOrderModel.fromJson(data);
      success(detailModel);
    }, (error) => failure(error));
  }

  void cancelOrderWithOrderNo(String orderNo, Function success, Function failure){
    TLDBaseRequest request =
        TLDBaseRequest({'orderNo': orderNo}, 'order/cancel');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

//walletAdress 买家地址
  void confirmPaid(String orderNo,String walletAdress, Function success, Function failure){
    TLDBaseRequest request =
        TLDBaseRequest({'orderNo': orderNo,'walletAddress':walletAdress,'sign':'dwqdqwdqwdqw'}, 'order/confirmPaid');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }

  //walletAdress 卖家地址
  void sureSentCoin(String orderNo,String walletAdress, Function success, Function failure){
    TLDBaseRequest request =
        TLDBaseRequest({'orderNo': orderNo,'walletAddress':walletAdress,'sign':'dwqdqwdqwdqw'}, 'order/confirmReceived');
    request.postNetRequest((dynamic value) {
      success();
    }, (error) => failure(error));
  }
}
