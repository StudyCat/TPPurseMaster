


import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDAcceptanceProfitSpillListModel {
  int billId;
  int billLevel;
  String billIcon;
  String overflowCount;
  int overflowId;
  String tip;
  bool lock;
  int overflowType;// "溢出类型（1：静态收益，2：推广收益）")

  TLDAcceptanceProfitSpillListModel(
      {this.billId, this.billLevel, this.billIcon, this.overflowCount,this.tip,this.lock,this.overflowType});

  TLDAcceptanceProfitSpillListModel.fromJson(Map<String, dynamic> json) {
    billId = json['billId'];
    billLevel = json['billLevel'];
    billIcon = json['billIcon'];
    overflowCount = json['overflowCount'];
    overflowId = json['overflowId'];
    tip = json['tip'];
    lock = json['lock'];
    overflowType = json['overflowType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billId'] = this.billId;
    data['billLevel'] = this.billLevel;
    data['billIcon'] = this.billIcon;
    data['overflowCount'] = this.overflowCount;
    data['overflowId'] = this.overflowId;
    data['tip'] = this.tip;
    data['lock'] = this.lock;
    data['overflowType'] = this.overflowType;
    return data;
  }
}

class TLDAcceptanceProfitSpillModelManager {
  void getSpillList(Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'acpt/user/overflowProfit');
    request.postNetRequest((value) {
      List dataList = value;
      List result = [];
      for (Map item in dataList) {
        result.add(TLDAcceptanceProfitSpillListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void getProfit(int overflowId,Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'overflowId':overflowId},'acpt/user/receiveProfit');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}