import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class TLDError{
  int code;
  String msg;

  TLDError(int code,String msg){
    this.code = code;
    this.msg = msg;
  }
}

class TLDBaseRequest{
  static String baseUrl = 'http://192.168.1.120:8030/';
  Map pramatersMap;
  String subUrl;

  TLDBaseRequest(Map pramatersMap,String subUrl){
    this.pramatersMap = pramatersMap;
    this.subUrl = subUrl;
  }


  void getNetRequest(Function(String) success, Function(TLDError) failure) async{
    try{
      Dio dio = Dio();
      Options options = Options(
        contentType : 'application/json', 
     );
     Response response = await dio.get(baseUrl+this.subUrl,queryParameters: this.pramatersMap,options: options);
     String jsonString = response.data;
     Map responseMap = jsonDecode(jsonString);
     String codeStr = responseMap['code'];
     String dataStr = responseMap['data'];
     if(int.parse(codeStr) == 200){
       success(dataStr);
     }else{
       TLDError error = TLDError(int.parse(codeStr),responseMap['msg']);
       failure(error);
     }
    }catch(e){
      TLDError error = TLDError(400,'网络接口出错');
       failure(error);
    }
  }

  void postNetRequest(ValueChanged<dynamic> success, Function(TLDError) failure) async{
    // try{
      BaseOptions options = BaseOptions(
        contentType : 'application/json',
     );
      Dio dio = Dio(options);
     String url = baseUrl + this.subUrl;
     Response response = await dio.post(url,queryParameters: Map<String, dynamic>.from(this.pramatersMap));
     Map responseMap = response.data;
     String codeStr = responseMap['code'];
     dynamic dataStr = responseMap['data'];
     if(int.parse(codeStr) == 200){
       success(dataStr);
     }else{
       TLDError error = TLDError(int.parse(codeStr),responseMap['msg']);
       failure(error);
     }
    // }catch(e){
    //   TLDError error = TLDError(400,'网络接口出错');
    //    failure(error);
    // }
  } 
}