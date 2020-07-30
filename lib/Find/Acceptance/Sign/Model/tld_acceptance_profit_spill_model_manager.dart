


import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDAcceptanceProfitSpillListModel {
  int billId;
  int billLevel;
  String billIcon;
  String overflowCount;
  int overflowId;

  TLDAcceptanceProfitSpillListModel(
      {this.billId, this.billLevel, this.billIcon, this.overflowCount});

  TLDAcceptanceProfitSpillListModel.fromJson(Map<String, dynamic> json) {
    billId = json['billId'];
    billLevel = json['billLevel'];
    billIcon = json['billIcon'];
    overflowCount = json['overflowCount'];
    overflowId = json['overflowId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billId'] = this.billId;
    data['billLevel'] = this.billLevel;
    data['billIcon'] = this.billIcon;
    data['overflowCount'] = this.overflowCount;
    data['overflowId'] = this.overflowId;
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