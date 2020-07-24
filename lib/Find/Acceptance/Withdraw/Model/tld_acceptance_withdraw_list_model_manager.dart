import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Drawer/PaymentTerm/Model/tld_payment_manager_model_manager.dart';

class TLDAcceptanceWithdrawOrderListModel {
  bool amApply;
  String cashNo;
  int acptUserId;
  int inviteUserId;
  String applyUserName;
  String inviteUserName;
  int cashType;
  String tldCount;
  String cashPrice;
  int payId;
  TLDPaymentModel payMethodVO;
  String applyWalletAddress;
  String inviteWalletAddress;
  int cashStatus;
  int createTime;
  int expireTime;
  int finishTime;
  String chargeRate;
  String chargeValue;
  int appealStatus;
  int appealId;

  TLDAcceptanceWithdrawOrderListModel(
      {this.amApply,
      this.cashNo,
      this.acptUserId,
      this.inviteUserId,
      this.applyUserName,
      this.inviteUserName,
      this.cashType,
      this.tldCount,
      this.cashPrice,
      this.payId,
      this.payMethodVO,
      this.inviteWalletAddress,
      this.applyWalletAddress,
      this.cashStatus,
      this.createTime,
      this.expireTime,
      this.finishTime,
      this.chargeRate,
      this.chargeValue,
      this.appealStatus,this.appealId});

  TLDAcceptanceWithdrawOrderListModel.fromJson(Map<String, dynamic> json) {
    amApply = json['amApply'];
    cashNo = json['cashNo'];
    acptUserId = json['acptUserId'];
    inviteUserId = json['inviteUserId'];
    applyUserName = json['applyUserName'];
    inviteUserName = json['inviteUserName'];
    cashType = json['cashType'];
    tldCount = json['tldCount'];
    cashPrice = json['cashPrice'];
    payId = json['payId'];
    payMethodVO = json['payMethodVO'] != null
        ? new TLDPaymentModel.fromJson(json['payMethodVO'])
        : null;
    inviteWalletAddress = json['inviteWalletAddress'];
    applyWalletAddress = json['applyWalletAddress'];
    cashStatus = json['cashStatus'];
    createTime = json['createTime'];
    expireTime = json['expireTime'];
    finishTime = json['finishTime'];
    chargeValue = json['chargeValue'];
    chargeRate = json['chargeRate'];
    appealStatus = json['appealStatus'];
    appealId = json['appealId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amApply'] = this.amApply;
    data['cashNo'] = this.cashNo;
    data['acptUserId'] = this.acptUserId;
    data['inviteUserId'] = this.inviteUserId;
    data['applyUserName'] = this.applyUserName;
    data['inviteUserName'] = this.inviteUserName;
    data['cashType'] = this.cashType;
    data['tldCount'] = this.tldCount;
    data['cashPrice'] = this.cashPrice;
    data['payId'] = this.payId;
    if (this.payMethodVO != null) {
      data['payMethodVO'] = this.payMethodVO.toJson();
    }
    data['inviteWalletAddress'] = this.inviteWalletAddress;
    data['applyWalletAddress'] = this.applyWalletAddress;
    data['cashStatus'] = this.cashStatus;
    data['createTime'] = this.createTime;
    data['expireTime'] = this.expireTime;
    data['finishTime'] = this.finishTime;
    data['chargeValue'] = this.chargeValue;
    data['chargeRate'] = this.chargeRate;
    data['appealStatus'] = this.appealStatus;
    data['appealId'] = this.appealId;
    return data;
  }
}

class TLDAcceptanceWithdrawListModelManager {
  void getWaitPayOrderList(int page,Function(List) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'pageNo':page,'pageSize':10},'acpt/cash/cashApply');
    request.postNetRequest((value) {
      List dataList = value['list'];
      List result = [];
      for (Map item in dataList) {
        result.add(TLDAcceptanceWithdrawOrderListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }

  void getOtherStatusOrderList(int page,Function(List) success,Function(TLDError) failure){
     TLDBaseRequest request = TLDBaseRequest({'pageNo':page,'pageSize':10},'acpt/cash/cashHistory');
    request.postNetRequest((value) {
      List dataList = value['list'];
      List result = [];
      for (Map item in dataList) {
        result.add(TLDAcceptanceWithdrawOrderListModel.fromJson(item));
      }
      success(result);
    }, (error) => failure(error));
  }
}