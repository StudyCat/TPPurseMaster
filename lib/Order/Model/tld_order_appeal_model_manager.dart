


import 'dart:convert';
import 'dart:io';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

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
}