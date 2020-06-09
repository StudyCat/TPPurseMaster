

import 'dart:io';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDIMModelManager{
  void uploadImageInservice(File image,Function(String) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({},'');
    request.uploadFile([image], (List urlList){
      Map urlMap = urlList.first;
      success(urlMap['url']);
    }, (TLDError error){
      failure(error);
    });
  }
}