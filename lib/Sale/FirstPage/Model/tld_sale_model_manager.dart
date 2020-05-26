import 'dart:convert';

import '../../../Base/tld_base_request.dart';
import 'tld_sale_list_info_model.dart';
import '../../../CommonWidget/tld_data_manager.dart';
import '../../../dataBase/tld_database_manager.dart';


class TLDSaleModelManager{
  void getSaleList(Function(List) success,Function(TLDError) failure) {
    List purseList = TLDDataManager.instance.purseList;
      List addressList = [];
      for (TLDWallet item in purseList) {
        addressList.add(item.address);
      }
      String addressListJson = jsonEncode(addressList);
    TLDBaseRequest request = TLDBaseRequest({'walletAddressList':addressListJson},'sell/list');
    request.postNetRequest((dynamic data) { 
      Map dataMap = data;
      List dataList = dataMap['list'];
      List result = [];
      for (Map item in dataList) {
        TLDSaleListInfoModel model = TLDSaleListInfoModel.fromJson(item);
        result.add(model);
      }
      success(result);
    }, (error) => failure(error));
  }
}