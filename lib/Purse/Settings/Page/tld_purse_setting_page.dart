import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../View/tld_purse_setting_cell.dart';
import '../../../CommonWidget/tld_alert_view.dart';
import 'tld_purse_setting_backup_word_page.dart';
import 'tld_export_key_page.dart';
import 'tld_delete_purse_success_page.dart';

class TLDPurseSettingPage extends StatefulWidget {
  TLDPurseSettingPage({Key key}) : super(key: key);

  @override
  _TLDPurseSettingPageState createState() => _TLDPurseSettingPageState();
}

class _TLDPurseSettingPageState extends State<TLDPurseSettingPage> {

  List titles = [
    '更改钱包名称',
    '备份钱包助记词',
    '导出私钥',
    '删除钱包',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'purse_setting_page',
        transitionBetweenRoutes: false,
        middle: Text('钱包设置'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(BuildContext context){
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index){
        return TLDPurseSettingCell(title : titles[index],
          didClickCallBack: (){
            if (index == 0){
              changePurseName(context);
            }else if (index == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TLDPurseSeetingBackWordPage()));
            }else if (index == 2){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TLDExportKeyPage()));
            }else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDeletePurseSuccessPage()));
            }
          },
        );
      }
    );
  }

  void changePurseName(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return TLDAlertView(title : '修改钱包名称',type : TLDAlertViewType.input,didClickSureBtn: (){
          showDialog(context: context,
            builder: (BuildContext context){
              return TLDAlertView(title : '输入安全密码',type : TLDAlertViewType.input,didClickSureBtn:(){});
            }
          );
        },);
      }
    );
  }

}