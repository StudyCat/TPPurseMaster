

import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TLDGetTaskPramaterModel{
  String walletAddress;
  String taskNo;
}

class TLDMissionListModel {
  int taskId;
  String taskNo;
  int taskLevel;
  int startTime;
  int endTime;
  int expireTime;//剩余时间 以分为单位
  String taskDesc;
  String levelIcon;

  TLDMissionListModel(
      {this.taskId,
      this.taskNo,
      this.taskLevel,
      this.startTime,
      this.endTime,
      this.expireTime,
      this.taskDesc,
      this.levelIcon});

  TLDMissionListModel.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    taskNo = json['taskNo'];
    taskLevel = json['taskLevel'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    expireTime = json['expireTime'];
    taskDesc = json['taskDesc'];
    levelIcon = json['levelIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['taskNo'] = this.taskNo;
    data['taskLevel'] = this.taskLevel;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['expireTime'] = this.expireTime;
    data['taskDesc'] = this.taskDesc;
    data['levelIcon'] = this.levelIcon;
    return data;
  }
}


class TLDMissionFirstModelManager{

  void getMission(TLDGetTaskPramaterModel pramaterModel,Function(int) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'taskNo':pramaterModel.taskNo,'walletAddress':pramaterModel.walletAddress}, 'task/receiveTask');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

  void getMissionListInfo(int page,Function(List) success,Function(TLDError) failure){
     List purseList = TLDDataManager.instance.purseList;
      List addressList = [];
      for (TLDWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
    TLDBaseRequest request = TLDBaseRequest({'list':addressListJson,'pageNo':page,'pageSize':10},'task/taskList');
    request.postNetRequest((value) {
      Map data = value;
      List dataList = data['list'];
      List result = [];
      for (Map item in dataList) {
        result.add(TLDMissionListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

}