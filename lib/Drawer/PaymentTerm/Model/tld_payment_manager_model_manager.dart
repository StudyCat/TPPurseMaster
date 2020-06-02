
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import '../Page/tld_payment_manager_page.dart';


class TLDPaymentModel {
  int createTime;
  String payMethodName;
  String imageUrl;
  String quota;
  int payId;
  int type;
  String walletAddress;
  String account;
  String subBranch;

  TLDPaymentModel(
      {this.createTime,
      this.payMethodName,
      this.imageUrl,
      this.quota,
      this.payId,
      this.type,
      this.walletAddress,
      this.account,
      this.subBranch});

  TLDPaymentModel.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    payMethodName = json['payMethodName'];
    imageUrl = json['imageUrl'];
    quota = json['quota'];
    payId = json['payId'];
    type = json['type'];
    walletAddress = json['walletAddress'];
    account = json['account'];
    subBranch = json['subBranch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['payMethodName'] = this.payMethodName;
    data['imageUrl'] = this.imageUrl;
    data['quota'] = this.quota;
    data['payId'] = this.payId;
    data['type'] = this.type;
    data['walletAddress'] = this.walletAddress;
    data['account'] = this.account;
    data['subBranch'] = this.subBranch;
    return data;
  }
}

class TLDPaymentManagerModelManager{
  void getPaymentInfoList(String walletAddress,TLDPaymentType type,Function(List) success,Function(TLDError)failure){
    String typeStr;
    if(type == TLDPaymentType.wechat){
      typeStr = '2';
    }else if(type == TLDPaymentType.alipay){
      typeStr = '3';
    }else{
      typeStr = '1';
    }
    TLDBaseRequest request = TLDBaseRequest({'type':typeStr,'walletAddress':walletAddress},'pay/queryPay');
    request.postNetRequest((dynamic value) {
      Map data = value;
      List dataList = data['list'];
      List result = [];
      for (Map item in dataList) {
        TLDPaymentModel model = TLDPaymentModel.fromJson(item);
        result.add(model);
      }
      success(result);
     }, (error) => failure(error));
  }
}