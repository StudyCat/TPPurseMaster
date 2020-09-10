import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_wallet_info_model.dart';

import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDRollOutAwardModel {
  TLDRollOutAwardModel({
    this.min,
    this.max,
    this.awardRate,
    this.isNeedAward,
    this.totalTld,
  });

  factory TLDRollOutAwardModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDRollOutAwardModel(
              min: asT<String>(jsonRes['min']),
              max: asT<String>(jsonRes['max']),
              awardRate: asT<String>(jsonRes['awardRate']),
              isNeedAward: asT<bool>(jsonRes['isNeedAward']),
              totalTld: asT<String>(jsonRes['totalTld']),
            );

  String min;
  String max;
  String awardRate;
  bool isNeedAward;
  String totalTld;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'min': min,
        'max': max,
        'awardRate': awardRate,
        'isNeedAward': isNeedAward,
        'totalTld': totalTld,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDRollOutPramaterModel {
  TLDWalletInfoModel infoModel;
  String amount;
}

class TLDRollOutModelManager {
  void getAwardInfo(Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest({},'acpt/user/billTransferRate');
    request.postNetRequest((value) {
      success(TLDRollOutAwardModel.fromJson(value));
    }, (error) => failure(error));
  }

  void rollOut(TLDRollOutPramaterModel pramaterModel,Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'toWalletAddress':pramaterModel.infoModel.walletAddress,'tsfCount':pramaterModel.amount},'acpt/user/billTransfer');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}
