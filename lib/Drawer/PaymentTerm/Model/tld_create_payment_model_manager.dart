
import 'dart:io';

import 'package:dragon_sword_purse/Base/tld_base_request.dart';

class TLDCreatePaymentPramaterModel{
  String account = '';
  String imageUrl = '';
  String quota = '';
  String realName = '';
  String subBranch = '';
  int type;
  String walletAddress = '';
  File imageFile;
}

class TLDCreatePaymentModelManager{
  
  void uploadWeChatOrAliPayQrCodeImage(TLDCreatePaymentPramaterModel pramaterModel,Function(String) success,Function(TLDError) failure){
    TLDBaseRequest request = TLDBaseRequest({}, '');
    request.uploadFile([pramaterModel.imageFile], (List urlList){
      Map urlMap = urlList.first;
      success(urlMap['url']);
    }, (error) => failure(error));
  }

   void createPayment(TLDCreatePaymentPramaterModel pramaterModel,Function success,Function(TLDError) failure){
     Map pramaterMap;
     if (pramaterModel.type != 1){
       pramaterMap = {'account':pramaterModel.account,'quota':pramaterModel.quota,'realName':pramaterModel.realName,'type':pramaterModel.type,'walletAddress':pramaterModel.walletAddress,'imageUrl':pramaterModel.imageUrl};
     }else{
       pramaterMap = {'account':pramaterModel.account,'quota':pramaterModel.quota,'realName':pramaterModel.realName,'type':pramaterModel.type,'walletAddress':pramaterModel.walletAddress,'subBranch':pramaterModel.subBranch};
     }
     TLDBaseRequest request = TLDBaseRequest(pramaterMap, 'pay/addPay');
     request.postNetRequest((dynamic value) {
        success();
     }, (error) => failure(error));
   }
}