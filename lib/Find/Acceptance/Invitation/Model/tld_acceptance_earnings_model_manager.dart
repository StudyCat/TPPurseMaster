import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDInviteTeamModel {
  int totalUserCount;
  List<TLDInviteUserModel> userList;
  String totalProfit;
  String level;
  bool isOpen = false;

  TLDInviteTeamModel({this.totalUserCount, this.userList, this.totalProfit,this.level});

  TLDInviteTeamModel.fromJson(Map<String, dynamic> json) {
    totalUserCount = json['totalUserCount'];
    if (json['userList'] != null) {
      userList = new List();
      json['userList'].forEach((v) {
        userList.add(new TLDInviteUserModel.fromJson(v));
      });
    }
    totalProfit = json['totalProfit'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalUserCount'] = this.totalUserCount;
    // data['userList'] = this.userList;
    data['totalProfit'] = this.totalProfit;
    data['level'] = this.level;
    return data;
  }
}

class TLDInviteUserModel{
  String userName;
  String profitAmount;

  TLDInviteUserModel({this.userName, this.profitAmount, });

  TLDInviteUserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    profitAmount = json['profitAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['profitAmount'] = this.profitAmount;
    return data;
  }
}

class TLDAcceptanceEarningsModelManager {
    void getInviteTeamInfo(String tel,Function(List) success,Function(TLDError) failure){
      TLDBaseRequest request = TLDBaseRequest({'tel':tel}, 'acpt/user/inviteProfit');
      request.postNetRequest((value) {
        List data = value;
        List result = [];
        for (Map item in data) {
          result.add(TLDInviteTeamModel.fromJson(item));
        }
        success(result);
      }, (error) => failure(error));
    }
}