import 'dart:convert';

import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';
import '../../../Base/tld_base_request.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../Model/tld_wallet_info_model.dart';

class TLDPurseModelManager{

  void getWalletListData(Function(List<TLDWalletInfoModel>) success,Function(TLDError) failure)async {
      List purseList = TLDDataManager.instance.purseList;
      List addressList = [];
      for (TLDWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
      TLDBaseRequest request = TLDBaseRequest({"list":addressListJson}, 'wallet/queryWallet');
     request.postNetRequest((dynamic data) {
      Map dataMap = data;
      List dataList = dataMap['list'];
      List<TLDWalletInfoModel> result = [];
      for (TLDWallet wallet in purseList) {
        for (Map infoMap in dataList) {
          if (infoMap['walletAddress'] == wallet.address){
            TLDWalletInfoModel model = TLDWalletInfoModel.fromJson(infoMap);
            model.wallet = wallet;
            result.add(model);
            break;
          }
        }
      }
      success(result);
       }, (error)=> failure(error));
  }


  void getAllAmount(Function(String) success,Function(TLDError) failure){
      List purseList = TLDDataManager.instance.purseList;
      List addressList = [];
      for (TLDWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
      TLDBaseRequest request = TLDBaseRequest({"list":addressListJson}, 'wallet/queryAccountTotal');
      request.postNetRequest((value) {
        Map data = value;
        success(data['total']);
      }, (error) => failure(error));
  }

}