import 'dart:convert' show json;

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/AAA/Model/tld_aaa_person_center_model_manager.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDAAATeamModel {
  TLDAAATeamModel({
    this.aaaLevel,
    this.size,
    this.lock,
    this.teamList,
    this.levelIcon,
    this.isNeedUpgrade = false,
    this.isOpen = false
  });

  factory TLDAAATeamModel.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null) {
      return null;
    }
    final List<TLDAAATeamListModel> teamList =
        jsonRes['teamList'] is List ? <TLDAAATeamListModel>[] : null;
    if (teamList != null) {
      for (final dynamic item in jsonRes['teamList']) {
        if (item != null) {
          teamList.add(
              TLDAAATeamListModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return TLDAAATeamModel(
      aaaLevel: asT<int>(jsonRes['aaaLevel']),
      size: asT<int>(jsonRes['size']),
      lock: asT<bool>(jsonRes['lock']),
      teamList: teamList,
      levelIcon: asT<String>(jsonRes['levelIcon']),
      isNeedUpgrade: false,
      isOpen: false
    );
  }

  int aaaLevel;
  int size;
  bool lock;
  List<TLDAAATeamListModel> teamList;
  String levelIcon;
  bool isOpen; // 是否展开
  bool isNeedUpgrade;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'aaaLevel': aaaLevel,
        'size': size,
        'lock': lock,
        'teamList': teamList,
        'levelIcon': levelIcon,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDAAATeamListModel {
  TLDAAATeamListModel({
    this.nickName,
    this.aaaUserId,
  });

  factory TLDAAATeamListModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDAAATeamListModel(
              nickName: asT<String>(jsonRes['nickName']),
              aaaUserId: asT<int>(jsonRes['aaaUserId']),
            );

  String nickName;
  int aaaUserId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'nickName': nickName,
        'aaaUserId': aaaUserId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDAAAFriendTeamModelManager {
  void getTeamInfo(Function success,Function failure) {
    TLDBaseRequest request = TLDBaseRequest({},"aaa/teamList");
    request.postNetRequest((value) {
      List result = [];
      for (Map item in value) {
        result.add(TLDAAATeamModel.fromJson(item));
      }
      for (TLDAAATeamModel item in result) {
        if (item.lock == true){
          item.isNeedUpgrade = true;
          break;
        }
      }
      success(result);
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
