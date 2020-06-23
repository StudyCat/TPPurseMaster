


import 'dart:convert';
import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Message/Model/tld_just_notice_vote_model_manager.dart';

class TLDOrderAppealModelManager{

  void uploadImageToService(List files,Function(List) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'');
    request.uploadFile(files, (List urlList){
      List list = [];
      for (Map urlMap in urlList) {
        list.add(urlMap['url']);
      }
      success(list);
    }, (error) => failure(error));
  }

  void orderAppealToService(List imageUrls,String appealDesc,String orderNo,Function success,Function(TLDError)failure){
      String listJson = jsonEncode(imageUrls);
      TLDBaseRequest request = TLDBaseRequest({'desc':appealDesc,'imgList':listJson,'orderNo':orderNo},'appeal/create');
      request.postNetRequest((dynamic value) {
          success();
      }, (error) => failure(error));
    }

  void getAppealInfo(int appealId,Function(TLDOrderAppealModel) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({'appealId':appealId},'appeal/appealDetail');
    request.postNetRequest((value) {
      Map dataMap = value;
      TLDOrderAppealModel appealModel = TLDOrderAppealModel.fromJson(dataMap);
      success(appealModel);
    }, (error) => failure(error));
  }
}