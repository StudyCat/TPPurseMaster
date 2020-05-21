import 'package:shared_preferences/shared_preferences.dart';


class TLDDataManager{
  // 工厂模式
  factory TLDDataManager() =>_getInstance();
  static TLDDataManager get instance => _getInstance();
  static TLDDataManager _instance;

  String password;  

  TLDDataManager._internal() {
    // 初始化

   getPassword();
  }


  Future<String>  getPassword()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    password = pre.getString('password');
  } 


  static TLDDataManager _getInstance() {
    if (_instance == null) {
      _instance = new TLDDataManager._internal();
    }
    return _instance;
  }




}