

import 'dart:convert';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_data_manager.dart';
import 'package:dragon_sword_purse/Find/RedEnvelope/Model/tld_detail_red_envelope_model_manager.dart';
import 'package:dragon_sword_purse/dataBase/tld_database_manager.dart';

class TLDRecieveRedEnvelopeModelManager{
  void getRedEnvelopeInfo(String redEnvelopeId,Function(TLDDetailRedEnvelopeModel) success,Function(TLDError) failure ){
    TLDBaseRequest request = TLDBaseRequest({'redEnvelopeId':redEnvelopeId},'redEnvelope/redEnvelopeDetail');
    request.postNetRequest((value) {
      TLDDetailRedEnvelopeModel detailRedEnvelopeModel = TLDDetailRedEnvelopeModel.fromJson(value);
      success(detailRedEnvelopeModel);
    }, (error) => failure(error));
  }

  void recieveRedEnvelope(String redEnvelopeId,String walletAddress,Function success,Function(TLDError) failure ){
    TLDBaseRequest request = TLDBaseRequest({'redEnvelopeId':redEnvelopeId,'receiveWalletAddress':walletAddress},'redEnvelope/receiveRedEnvelope');
    request.postNetRequest((value) {
      success(value);
    }, (error) => failure(error));
  }

  void getRecieveRedEnvelopeList(int page, Function success,Function failure){
    List purseList = TLDDataManager.instance.purseList;
    List addressList = [];
    for (TLDWallet item in purseList) {
      addressList.add(item.address);
    }
    String addressListJson = jsonEncode(addressList);
    TLDBaseRequest request = TLDBaseRequest({'list':addressListJson,'pageNo':page,'pageSize': '10'},'redEnvelope/receiveLogList');
    request.postNetRequest((value) {
       List list = value['list'];
       List result = [];
       for (var item in list) {
         result.add(TLDRedEnvelopeReiceveModel.fromJson(item));
       }
       success(result);
     }, (error) => failure(error));
  }
}