

class TLDDetailSaleModel {
  int sellId;
  int createTime;
  String payMethod;
  String currentCount;
  String sellNo;
  String walletAddress;

  TLDDetailSaleModel(
      {this.sellId,
      this.createTime,
      this.payMethod,
      this.currentCount,
      this.sellNo,
      this.walletAddress});

  TLDDetailSaleModel.fromJson(Map<String, dynamic> json) {
    sellId = json['sellId'];
    createTime = json['createTime'];
    payMethod = json['payMethod'];
    currentCount = json['currentCount'];
    sellNo = json['sellNo'];
    walletAddress = json['walletAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellId'] = this.sellId;
    data['createTime'] = this.createTime;
    data['payMethod'] = this.payMethod;
    data['currentCount'] = this.currentCount;
    data['sellNo'] = this.sellNo;
    data['walletAddress'] = this.walletAddress;
    return data;
  }
}