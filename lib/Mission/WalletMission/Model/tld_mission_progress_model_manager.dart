

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

class TLDMissionProgressModel {
  int taskId;
  String taskNo;
  int taskLevel;
  String levelIcon;
  String taskDesc;
  int completedCount;
  int taskCount;
  String progressCount;
  String receiveWalletAddress;
  String releaseWalletAddress;
  int status;
  int createTime;
  int startTime;
  int endTime;
  int expireTime;
  String taskOrderNoList;
  List<TaskOrderListModel> taskOrderList;

  TLDMissionProgressModel(
      {this.taskId,
      this.taskNo,
      this.taskLevel,
      this.levelIcon,
      this.taskDesc,
      this.completedCount,
      this.taskCount,
      this.progressCount,
      this.receiveWalletAddress,
      this.releaseWalletAddress,
      this.status,
      this.createTime,
      this.startTime,
      this.endTime,
      this.expireTime,
      this.taskOrderNoList,
      this.taskOrderList});

  TLDMissionProgressModel.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    taskNo = json['taskNo'];
    taskLevel = json['taskLevel'];
    levelIcon = json['levelIcon'];
    taskDesc = json['taskDesc'];
    completedCount = json['completedCount'];
    taskCount = json['taskCount'];
    progressCount = json['progressCount'];
    receiveWalletAddress = json['receiveWalletAddress'];
    releaseWalletAddress = json['releaseWalletAddress'];
    status = json['status'];
    createTime = json['createTime'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    expireTime = json['expireTime'];
    taskOrderNoList = json['taskOrderNoList'];
    if (json['taskOrderList'] != null) {
      taskOrderList = new List<TaskOrderListModel>();
      json['taskOrderList'].forEach((v) {
        taskOrderList.add(new TaskOrderListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['taskNo'] = this.taskNo;
    data['taskLevel'] = this.taskLevel;
    data['levelIcon'] = this.levelIcon;
    data['taskDesc'] = this.taskDesc;
    data['completedCount'] = this.completedCount;
    data['taskCount'] = this.taskCount;
    data['progressCount'] = this.progressCount;
    data['receiveWalletAddress'] = this.receiveWalletAddress;
    data['releaseWalletAddress'] = this.releaseWalletAddress;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['expireTime'] = this.expireTime;
    data['taskOrderNoList'] = this.taskOrderNoList;
    if (this.taskOrderList != null) {
      data['taskOrderList'] =
          this.taskOrderList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskOrderListModel {
  int orderId;
  String orderNo;
  String taskBuyNo;
  int taskLevel;
  String quote;
  String profit;
  String buyerWalletAddress;
  String sellerWalletAddress;
  int payId;
  TLDPaymentModel payMethodVO;
  String createTime;
  int status;

  TaskOrderListModel(
      {this.orderId,
      this.orderNo,
      this.taskBuyNo,
      this.taskLevel,
      this.quote,
      this.profit,
      this.buyerWalletAddress,
      this.sellerWalletAddress,
      this.payId,
      this.payMethodVO,
      this.createTime,
      this.status});

  TaskOrderListModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    taskBuyNo = json['taskBuyNo'];
    taskLevel = json['taskLevel'];
    quote = json['quote'];
    profit = json['profit'];
    buyerWalletAddress = json['buyerWalletAddress'];
    sellerWalletAddress = json['sellerWalletAddress'];
    payId = json['payId'];
    payMethodVO = json['payMethodVO'] != null
        ? new TLDPaymentModel.fromJson(json['payMethodVO'])
        : null;
    createTime = json['createTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['taskBuyNo'] = this.taskBuyNo;
    data['taskLevel'] = this.taskLevel;
    data['quote'] = this.quote;
    data['profit'] = this.profit;
    data['buyerWalletAddress'] = this.buyerWalletAddress;
    data['sellerWalletAddress'] = this.sellerWalletAddress;
    data['payId'] = this.payId;
    if (this.payMethodVO != null) {
      data['payMethodVO'] = this.payMethodVO.toJson();
    }
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    return data;
  }
}

class PayMethodVO {
  int payId;
  String realName;
  String walletAddress;
  int type;
  String payMethodName;
  String account;
  Null imageUrl;
  String subBranch;
  String quota;
  int createTime;

  PayMethodVO(
      {this.payId,
      this.realName,
      this.walletAddress,
      this.type,
      this.payMethodName,
      this.account,
      this.imageUrl,
      this.subBranch,
      this.quota,
      this.createTime});

  PayMethodVO.fromJson(Map<String, dynamic> json) {
    payId = json['payId'];
    realName = json['realName'];
    walletAddress = json['walletAddress'];
    type = json['type'];
    payMethodName = json['payMethodName'];
    account = json['account'];
    imageUrl = json['imageUrl'];
    subBranch = json['subBranch'];
    quota = json['quota'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payId'] = this.payId;
    data['realName'] = this.realName;
    data['walletAddress'] = this.walletAddress;
    data['type'] = this.type;
    data['payMethodName'] = this.payMethodName;
    data['account'] = this.account;
    data['imageUrl'] = this.imageUrl;
    data['subBranch'] = this.subBranch;
    data['quota'] = this.quota;
    data['createTime'] = this.createTime;
    return data;
  }
}


class TLDMissionProgressModelManager{
  
  void getMissionProgress(int taskWalletId,Function(TLDMissionProgressModel) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'taskWalletId':taskWalletId,},'task/taskProgress');
    request.postNetRequest((value) {
      Map data = value;
      success(TLDMissionProgressModel.fromJson(data));
    }, (error) => failure(error));
  }

}