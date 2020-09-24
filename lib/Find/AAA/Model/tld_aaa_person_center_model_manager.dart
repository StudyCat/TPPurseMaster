import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_change_user_info_model_manager.dart';
import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDAAAUpgradeInfoModel {
  TLDAAAUpgradeInfoModel({
    this.curLevel,
    this.fullTldCount,
    this.nextLevelIcon,
    this.nextLevel,
    this.nextTldCount,
    this.curLevelIcon,
  });

  factory TLDAAAUpgradeInfoModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDAAAUpgradeInfoModel(
              curLevel: asT<int>(jsonRes['curLevel']),
              fullTldCount: asT<String>(jsonRes['fullTldCount']),
              nextLevelIcon: asT<String>(jsonRes['nextLevelIcon']),
              nextLevel: asT<int>(jsonRes['nextLevel']),
              nextTldCount: asT<String>(jsonRes['nextTldCount']),
              curLevelIcon: asT<String>(jsonRes['curLevelIcon']),
            );

  int curLevel;
  String fullTldCount;
  String nextLevelIcon;
  int nextLevel;
  String nextTldCount;
  String curLevelIcon;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'curLevel': curLevel,
        'fullTldCount': fullTldCount,
        'nextLevelIcon': nextLevelIcon,
        'nextLevel': nextLevel,
        'nextTldCount': nextTldCount,
        'curLevelIcon': curLevelIcon,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDAAAPersonFriendCenterModelManager {
  void getUserInfo(Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest({}, 'aaa/accountInfo');
    request.postNetRequest((value) {
      Map valueMap = value;
      if (valueMap.length == 0) {
        success(TLDAAAUserInfo());
      } else {
        success(TLDAAAUserInfo.fromJson(valueMap));
      }
    }, (error) => failure(error));
  }

  void getUpgradeInfo(Function success, Function failure){
    TLDBaseRequest request = TLDBaseRequest(
        {}, 'aaa/nextLevelInfo');
    request.postNetRequest((value) {
      success(TLDAAAUpgradeInfoModel.fromJson(value));
    }, (error) => failure(error));
  }

  void upgrade(
      int type, String walletAddress, Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest(
        {'type': type, 'walletAddress': walletAddress}, 'aaa/upgrade');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}
