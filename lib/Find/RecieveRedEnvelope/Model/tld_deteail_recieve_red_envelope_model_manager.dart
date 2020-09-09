


import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';

class TLDDetailRecieveRedEnvelopeModelManager{
  void getDetailInfo(int receiveLogId,Function(TLDDetailRedEnvelopeModel) success,Function failure){
    TLDBaseRequest request = TLDBaseRequest({'receiveLogId':receiveLogId}, 'redEnvelope/receiveLogDetail');
    request.postNetRequest((value) {
      success(TLDDetailRedEnvelopeModel.fromJson(value));
    }, (error) => failure(error));
  }
}