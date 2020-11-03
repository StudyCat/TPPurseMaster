import 'dart:convert' show json;
import 'package:dragon_sword_purse/Base/tld_base_request.dart';

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class TLDTeamStarModel {
  TLDTeamStarModel({
    this.curProfit,
    this.teamLevel,
    this.addProfit,
    this.starLevel,
    this.levelIcon,
  });

  factory TLDTeamStarModel.fromJson(Map<String, dynamic> jsonRes) =>
      jsonRes == null
          ? null
          : TLDTeamStarModel(
              curProfit: asT<String>(jsonRes['curProfit']),
              teamLevel: asT<int>(jsonRes['teamLevel']),
              addProfit: asT<String>(jsonRes['addProfit']),
              starLevel: asT<int>(jsonRes['starLevel']),
              levelIcon: asT<String>(jsonRes['levelIcon']),
            );

  String curProfit;
  int teamLevel;
  String addProfit;
  int starLevel;
  String levelIcon;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'curProfit': curProfit,
        'teamLevel': teamLevel,
        'addProfit': addProfit,
        'starLevel': starLevel,
        'levelIcon': levelIcon,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}

class TLDAAAPlusStarPramater{
  String walletAddress;
  int payType;
  int starNum;
  int teamLevel;
  int ylbType;

  TLDAAAPlusStarPramater({this.payType = 1,this.walletAddress = '',this.starNum = 0});
}

class TLDAAAPlusStarModelManager {
  void getStarList(Function success, Function failure) {
    TLDBaseRequest request = TLDBaseRequest({}, 'aaa/upgradeStarDetail');
    request.postNetRequest((value) {
      List starList = value['list'];
      List result = [];
      for (Map item in starList) {
        result.add(TLDTeamStarModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }


  void getStarAmount(int teamLevel,int starNum,Function success, Function failure){
    TLDBaseRequest request = TLDBaseRequest({'teamLevel':teamLevel,'starNum' : starNum}, 'aaa/upgradeCondition');
    request.postNetRequest((value) {
      success(value['totalPrice']);
    }, (TLDError error) => failure(error));
  }


  void upgrade(TLDAAAPlusStarPramater pramater,Function success,Function failure){
    Map pramaters;
    if (pramater.payType == 1){
      pramaters = {'teamLevel': pramater.teamLevel, 'walletAddress': pramater.walletAddress,'payType':pramater.payType,'starNum':pramater.starNum};
    }else{
      pramaters = {'teamLevel': pramater.teamLevel, 'ylbType': pramater.ylbType,'payType':pramater.payType,'starNum':pramater.starNum};
    }
    TLDBaseRequest request = TLDBaseRequest(
        pramaters, 'aaa/upgradeStarLevel');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}
