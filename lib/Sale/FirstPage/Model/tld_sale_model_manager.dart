import 'dart:convert';
import '../../../Base/tld_base_request.dart';
import 'tld_sale_list_info_model.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../dataBase/tld_database_manager.dart';


class TLDSaleModelManager{
  void getSaleList(int type,Function(List) success,Function(TLDError) failure) {
    List purseList = TLDDataManager.instance.purseList;
      List addressList = [];
      for (TLDWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
    TLDBaseRequest request = TLDBaseRequest({'walletAddressList':addressListJson,'type':type},'sell/list');
    request.postNetRequest((dynamic data) { 
      Map dataMap = data;
      List dataList = dataMap['list'];
      List result = [];
      for (Map item in dataList) {
        TLDSaleListInfoModel model = TLDSaleListInfoModel.fromJson(item);
        result.add(model);
      }
      for (TLDSaleListInfoModel model in result) {
        for (TLDWallet wallet in purseList) {
          if(model.walletAddress == wallet.address){
              model.wallet = wallet;
              break;
          }
        }
      }
      success(result);
    }, (error) => failure(error));
  }

  void cancelSale(TLDSaleListInfoModel model,Function success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'sellNo':model.sellNo,'walletAddress':model.walletAddress},'sell/cancel');
    request.postNetRequest((dynamic data) {
      success();
     }, (TLDError error){
       if(error.code == 10000){
         model.realCount = error.msg;
         cancelSale(model, success, failure);
       }else{
         failure(error);
       }
     });
  }
}