import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Withdraw/Model/tld_acceptance_withdraw_list_model_manager.dart';

class TLDAcceptanceDetailWithdrawModelManager {
  void getDetailInfo(
      String cashNo,
      Function(TLDAcceptanceWithdrawOrderListModel) success,
      Function(TLDError) failure) {
    TLDBaseRequest request =
        TLDBaseRequest({'cashNo': cashNo}, 'acpt/cash/cashDetail');
    request.postNetRequest((value) {
      success(TLDAcceptanceWithdrawOrderListModel.fromJson(value));
    }, (error) => failure(error));
  }

  void cancelWithdraw(
      String cashNo, Function success, Function(TLDError) failure) {
    TLDBaseRequest request =
        TLDBaseRequest({'cashNo': cashNo}, 'acpt/cash/cancelCash');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void sentWithdrawTLD(
      String cashNo, Function success, Function(TLDError) failure) {
    TLDBaseRequest request =
        TLDBaseRequest({'cashNo': cashNo}, 'acpt/cash/confirmReceived');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void reminder(String cashNo, Function success, Function(TLDError) failure){
    TLDBaseRequest request =
        TLDBaseRequest({'cashNo': cashNo}, 'acpt/cash/reminder');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }

  void withdrawSurePay(
      String cashNo, Function success, Function(TLDError) failure) {
    TLDBaseRequest request =
        TLDBaseRequest({'cashNo': cashNo}, 'acpt/cash/confirmPay');
    request.postNetRequest((value) {
      success();
    }, (error) => failure(error));
  }
}
