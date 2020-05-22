import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../CommonWidget/tld_data_manager.dart';
import '../CommonWidget/tld_alert_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ceatePurse&importPurse/CreatePurse/Page/tld_create_purse_page.dart';

void jugeHavePassword(BuildContext context,Function passwordRightCallBack,TLDCreatePursePageType type,Function setPasswordSuccessCallBack){
   if(TLDDataManager.instance.password == null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> TLDCreatePursePage(type: type,setPasswordSuccessCallBack: setPasswordSuccessCallBack,)));
    }else{
      String password;
      showDialog(context: context,builder: (BuildContext context){
        return TLDAlertView(title:'输入安全密码',type : TLDAlertViewType.input,textEditingCallBack: (String text){
          password = text;
        },didClickSureBtn: (){
          if (password == TLDDataManager.instance.password) {
            passwordRightCallBack();
          } else {
            Fluttertoast.showToast(
                        msg: "安全密码错误",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1);
          }
        },);
      });
    }
}

 