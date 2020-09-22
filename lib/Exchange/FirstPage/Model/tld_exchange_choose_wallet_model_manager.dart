import '../../../Base/tld_base_request.dart';
import '../../../Purse/FirstPage/Model/tld_wallet_info_model.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../dataBase/tld_database_manager.dart';
import 'dart:convert';



class TLDExchangeChooseWalletModelManager{
  void getWalletListData(bool isNeedFilter,Function(List<TLDWalletInfoModel>) success,Function(TLDError) failure)async {
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
      List canChangeList = [];
      if (isNeedFilter == true){
        for (Map item in dataList) {
          if(item['existSell'] == false){
            canChangeList.add(item);
        }
      }
      }else{
        canChangeList = List.from(dataList);
      }
      List<TLDWalletInfoModel> result = [];
      for (TLDWallet wallet in purseList) {
        for (Map infoMap in canChangeList) {
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


  void bindingWalletAddress(String walletAddress, Function success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'walletAddress' : walletAddress}, 'acpt/user/bindWallet');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

}