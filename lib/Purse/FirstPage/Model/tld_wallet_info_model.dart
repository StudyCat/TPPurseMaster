import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import 'package:flutter/material.dart';


class TLDWalletInfoModel {
  String createTime;
  List<PayMethodList> payMethodList;
  String walletName;
  bool lock;
  String walletAddress;
  String value;
  TLDWallet wallet;
  bool existSell;

  TLDWalletInfoModel(
      {this.createTime,
      this.payMethodList,
      this.walletName,
      this.lock,
      this.walletAddress,
      this.value,
      this.existSell,
      this.wallet});

  TLDWalletInfoModel.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    if (json['payMethodList'] != null) {
      payMethodList = new List<PayMethodList>();
      json['payMethodList'].forEach((v) {
        payMethodList.add(new PayMethodList.fromJson(v));
      });
    }
    walletName = json['walletName'];
    lock = json['lock'];
    existSell = json['existSell'];
    walletAddress = json['walletAddress'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    if (this.payMethodList != null) {
      data['payMethodList'] =
          this.payMethodList.map((v) => v.toJson()).toList();
    }
    data['walletName'] = this.walletName;
    data['lock'] = this.lock;
    data['walletAddress'] = this.walletAddress;
    data['value'] = this.value;
    data['existSell'] = this.existSell;
    return data;
  }
}

class PayMethodList {
  String payMethodName;
  String imageUrl;
  String payAccount;

  PayMethodList({this.payMethodName, this.imageUrl, this.payAccount});

  PayMethodList.fromJson(Map<String, dynamic> json) {
    payMethodName = json['payMethodName'];
    imageUrl = json['imageUrl'];
    payAccount = json['payAccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payMethodName'] = this.payMethodName;
    data['imageUrl'] = this.imageUrl;
    data['payAccount'] = this.payAccount;
    return data;
  }
}