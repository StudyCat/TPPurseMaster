import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

import 'package:dragon_sword_purse/Find/Acceptance/Sign/Model/tld_acceptance_sign_model_manager.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDAAAUserInfo {
  TLDAAAUserInfo({
    this.nickName,
    this.wechat,
    this.tel,
    this.walletAddress,
    this.inviteWechat,
    this.totalProfit,
    this.levelIcon,
    this.aaaLevel,
    this.balance,
    this.signList,
    this.curTime
  });

  factory TLDAAAUserInfo.fromJson(Map<String, dynamic> jsonRes) {
    if (jsonRes == null){
      return null;
    }

    final List<TLDSignModel> signList =
        jsonRes['signList'] is List ? <TLDSignModel>[] : null;
    if (signList != null) {
      for (final dynamic item in jsonRes['signList']) {
        if (item != null) {
          signList.add(
              TLDSignModel.fromJson(asT<Map<String, dynamic>>(item)));
        }
      }
    }

    return  TLDAAAUserInfo(
              nickName: asT<String>(jsonRes['nickName']),
              wechat: asT<String>(jsonRes['wechat']),
              tel: asT<String>(jsonRes['tel']),
              walletAddress: asT<String>(jsonRes['walletAddress']),
              inviteWechat: asT<String>(jsonRes['inviteWechat']),
              totalProfit: asT<String>(jsonRes['totalProfit']),
              levelIcon: asT<String>(jsonRes['levelIcon']),
              aaaLevel : asT<int>(jsonRes['aaaLevel']),
              balance : asT<String>(jsonRes['balance']),
              curTime: asT<int>(jsonRes['curTime']),
              signList: signList
            );
  }

  int aaaLevel;
  String levelIcon;
  String nickName;
  String wechat;
  String balance;
  String tel;
  String walletAddress;
  String inviteWechat;
  String totalProfit;
  List signList;
  int curTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'nickName': nickName,
        'wechat': wechat,
        'tel': tel,
        'walletAddress': walletAddress,
        'inviteWechat': inviteWechat,
        'totalProfit': totalProfit,
        'levelIcon' : levelIcon,
        'aaaLevel' : aaaLevel,
        'balance' : balance,
        'curTime' : curTime
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDAAAChangeUserInfoModelManager {
  void getUserInfo(Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest({}, 'aaa/accountInfo');
    request.postNetRequest((value) {
      Map valueMap = value;
      if (valueMap.length == 0){
        success(TLDAAAUserInfo());
      }else{
        success(TLDAAAUserInfo.fromJson(valueMap));
      }
    }, (error) => failure(error));
  }

  void saveUserInfo(TLDAAAUserInfo userInfo,Function success, Function failure) {
    Map pramaterMap = {'nickName': userInfo.nickName,'walletAddress':userInfo.walletAddress,'wechat':userInfo.wechat,'tel':userInfo.tel};
    TLDBaseRequest request = TLDBaseRequest(pramaterMap,'aaa/editAccountInfo');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}
