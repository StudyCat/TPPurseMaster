import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDInviteDetailEarningModel {
  String userName;
  String tel;
  List<TLDEarningBillModel> list;
  String totalProfit;

  TLDInviteDetailEarningModel(
      {this.userName, this.tel, this.list, this.totalProfit});

  TLDInviteDetailEarningModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    tel = json['tel'];
    if (json['list'] != null) {
      list = new List<TLDEarningBillModel>();
      json['list'].forEach((v) {
        list.add(new TLDEarningBillModel.fromJson(v));
      });
    }
    totalProfit = json['totalProfit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['tel'] = this.tel;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['totalProfit'] = this.totalProfit;
    return data;
  }
}

class TLDEarningBillModel {
  int billLevel;
  int billCount;
  String totalPrice;
  String extensionProfit;

  TLDEarningBillModel({this.billLevel, this.billCount, this.totalPrice, this.extensionProfit});

  TLDEarningBillModel.fromJson(Map<String, dynamic> json) {
    billLevel = json['billLevel'];
    billCount = json['billCount'];
    totalPrice = json['totalPrice'];
    extensionProfit = json['extensionProfit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billLevel'] = this.billLevel;
    data['billCount'] = this.billCount;
    data['totalPrice'] = this.totalPrice;
    data['extensionProfit'] = this.extensionProfit;
    return data;
  }
}

class TLDAcceptanceInvitationDetailEarningModelManager {
  
  void getDetailEarningInfo(String userName,Function(TLDInviteDetailEarningModel) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'userName' : userName}, 'acpt/user/profitDetail');
    request.postNetRequest((value) {
      success(TLDInviteDetailEarningModel.fromJson(value));
    }, (error) => failure(error));
  }

}