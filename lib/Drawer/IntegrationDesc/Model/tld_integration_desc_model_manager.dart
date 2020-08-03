

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDIntergrationDescModelManager{

  void getRate(Function(String) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'wallet/tldRateDesc');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }
}
