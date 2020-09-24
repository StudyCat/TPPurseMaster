import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'dart:convert' show json;

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
    this.aaaLevel
  });

  factory TLDAAAUserInfo.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDAAAUserInfo(
              nickName: asT<String>(jsonRes['nickName']),
              wechat: asT<String>(jsonRes['wechat']),
              tel: asT<String>(jsonRes['tel']),
              walletAddress: asT<String>(jsonRes['walletAddress']),
              inviteWechat: asT<String>(jsonRes['inviteWechat']),
              totalProfit: asT<String>(jsonRes['totalProfit']),
              levelIcon: asT<String>(jsonRes['levelIcon']),
              aaaLevel : asT<int>(jsonRes['aaaLevel'])
            );

  int aaaLevel;
  String levelIcon;
  String nickName;
  String wechat;
  String tel;
  String walletAddress;
  String inviteWechat;
  String totalProfit;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'nickName': nickName,
        'wechat': wechat,
        'tel': tel,
        'walletAddress': walletAddress,
        'inviteWechat': inviteWechat,
        'totalProfit': totalProfit,
        'levelIcon' : levelIcon,
        'aaaLevel' : aaaLevel
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
