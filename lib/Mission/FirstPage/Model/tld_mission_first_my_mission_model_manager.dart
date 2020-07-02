

import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TLDMissionInfoModel {
  int taskWalletId;
  String taskNo;
  int taskLevel;
  String taskDesc;
  int completedCount;
  int taskCount;
  String receiveWalletAddress;
  String releaseWalletAddress;
  int status;
  int createTime;
  int startTime;
  int endTime;
  int expireTime;
  String levelIcon;
  String progressCount;//任务进度

  TLDMissionInfoModel(
      {this.taskWalletId,
      this.taskNo,
      this.taskLevel,
      this.taskDesc,
      this.completedCount,
      this.taskCount,
      this.receiveWalletAddress,
      this.releaseWalletAddress,
      this.status,
      this.createTime,
      this.startTime,
      this.endTime,
      this.expireTime,
      this.levelIcon,
      this.progressCount});

  TLDMissionInfoModel.fromJson(Map<String, dynamic> json) {
    taskWalletId = json['taskWalletId'];
    taskNo = json['taskNo'];
    taskLevel = json['taskLevel'];
    taskDesc = json['taskDesc'];
    completedCount = json['completedCount'];
    taskCount = json['taskCount'];
    receiveWalletAddress = json['receiveWalletAddress'];
    releaseWalletAddress = json['releaseWalletAddress'];
    status = json['status'];
    createTime = json['createTime'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    expireTime = json['expireTime'];
    levelIcon = json['levelIcon'];
    progressCount = json['progressCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskWalletId'] = this.taskWalletId;
    data['taskNo'] = this.taskNo;
    data['taskLevel'] = this.taskLevel;
    data['taskDesc'] = this.taskDesc;
    data['completedCount'] = this.completedCount;
    data['taskCount'] = this.taskCount;
    data['receiveWalletAddress'] = this.receiveWalletAddress;
    data['releaseWalletAddress'] = this.releaseWalletAddress;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['expireTime'] = this.expireTime;
    return data;
  }
}

class TLDMissionFirstMyMissionModelManager{

  void getMyMissionList(int page,Function(List) success,Function(TLDError) failure){
    List purseList = TLDDataManager.instance.purseList;
      List addressList = [];
      for (TLDWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
    TLDBaseRequest request = TLDBaseRequest({'list':addressListJson,'pageNo':page,'pageSize':10},'task/myTaskList');
    request.postNetRequest((value) {
      Map data = value;
      List dataList = data['list'];
      List result = [];
      for (Map item in dataList) {
        result.add(TLDMissionInfoModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

}