

import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TLDSignModel{
  String year;
  String month;
  List dayList;

  TLDSignModel(
      {this.year,
      this.month,
      this.dayList,
      });

  TLDSignModel.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    dayList = json['dayList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['dayList'] = this.dayList;
    return data;
  }
}


class TLDAcceptanceUserInfoModel {
  String userName;
  String tel;
  String avatar;
  String acptTotalScore;
  String acptSignScore;
  String acptSignTld;
  String idCard;
  String walletAddress;
  String extensionCode;
  String yearMonth;
  List signList;
  String curTime;
  String jwtToken;
  TLDWallet wallet;

  TLDAcceptanceUserInfoModel(
      {this.userName,
      this.tel,
      this.avatar,
      this.acptTotalScore,
      this.acptSignScore,
      this.acptSignTld,
      this.idCard,
      this.walletAddress,
      this.extensionCode,
      this.yearMonth,
      this.signList,
      this.jwtToken,
      this.curTime
      });

  TLDAcceptanceUserInfoModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    tel = json['tel'];
    avatar = json['avatar'];
    acptTotalScore = json['acptTotalScore'];
    acptSignScore = json['acptSignScore'];
    acptSignTld = json['acptSignTld'];
    idCard = json['idCard'];
    walletAddress = json['walletAddress'];
    extensionCode = json['extensionCode'];
    yearMonth = json['yearMonth'];
    signList = _getSignList(json['signList']);
    jwtToken = json['jwtToken'];
    curTime = json['curTime'];
  }

   List _getSignList(List jsonList){
     List result = [];
     for (Map item in jsonList) {
       result.add(TLDSignModel.fromJson(item));
     }
     return result;
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['tel'] = this.tel;
    data['avatar'] = this.avatar;
    data['acptTotalScore'] = this.acptTotalScore;
    data['acptSignTld'] = this.acptSignTld;
    data['idCard'] = this.idCard;
    data['walletAddress'] = this.walletAddress;
    data['extensionCode'] = this.extensionCode;
    data['yearMonth'] = this.yearMonth;
    data['signList'] = this.signList;
    data['jwtToken'] = this.jwtToken;
    data['curTime'] = this.curTime;
    return data;
  }
}


class TLDAcceptanceSignModelManager{

  void getUserInfo(Function(TLDAcceptanceUserInfoModel) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'acpt/user/getAcptUserInfo');
    request.postNetRequest((value) {
      TLDAcceptanceUserInfoModel userInfoModel = TLDAcceptanceUserInfoModel.fromJson(value);
      List purseList = TLDDataManager.instance.purseList;
      for (TLDWallet wallet in purseList) {
        if (wallet.address == userInfoModel.walletAddress){
          userInfoModel.wallet = wallet;
          break;
        }
      }
      success(userInfoModel);
    }, (error) => failure(error));
  }

  void changeWallet(String walletAddress,Function() success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'walletAddress':walletAddress},'acpt/user/changeWallet');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

 void sign(Function() success,Function(TLDError) failure){
   TLDBaseRequest request = TLDBaseRequest({},'acpt/user/acptSign');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
 }

}