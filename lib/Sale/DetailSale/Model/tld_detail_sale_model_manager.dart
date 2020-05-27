import 'package:dragon_sword_purse/Base/tld_base_request.dart';

import 'tld_detail_sale_model.dart';

class TLDDetailSaleModelManager{
  void getDetailSale(String saleNo,Function(TLDDetailSaleModel) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'sellNo':saleNo}, 'sell/detail');
    request.postNetRequest((dynamic value) { 
      success(TLDDetailSaleModel.fromJson(value));
    }, (error) => failure(error));
  }
}