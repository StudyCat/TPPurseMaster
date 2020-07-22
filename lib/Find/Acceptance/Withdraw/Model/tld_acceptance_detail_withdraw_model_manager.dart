

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';

class TLDAcceptanceDetailWithdrawModelManager {
  void getDetailInfo(String cashNo,Function(TLDAcceptanceWithdrawOrderListModel) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'cashNo' : cashNo},'acpt/cash/cashDetail');
    request.postNetRequest((value) {
      success(TLDAcceptanceWithdrawOrderListModel.fromJson(value));
    }, (error) => failure(error));
  }
}
