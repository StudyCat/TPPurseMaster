
class TLDSaleListInfoModel {
  int sellId;
  String sellNo;
  String walletAddress;
  String currentCount;
  String payMethod;
  int createTime;

  TLDSaleListInfoModel(
      {this.sellId,
      this.sellNo,
      this.walletAddress,
      this.currentCount,
      this.payMethod,
      this.createTime});

  TLDSaleListInfoModel.fromJson(Map<String, dynamic> json) {
    sellId = json['sellId'];
    sellNo = json['sellNo'];
    walletAddress = json['walletAddress'];
    currentCount = json['currentCount'];
    payMethod = json['payMethod'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellId'] = this.sellId;
    data['sellNo'] = this.sellNo;
    data['walletAddress'] = this.walletAddress;
    data['currentCount'] = this.currentCount;
    data['payMethod'] = this.payMethod;
    data['createTime'] = this.createTime;
    return data;
  }
}