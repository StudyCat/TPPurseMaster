import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tld_create_purse_success_page.dart';
import '../Model/create_purse_model_manager.dart';

class TLDCreatingPursePage extends StatefulWidget {
  TLDCreatingPursePage({Key key}) : super(key: key);

  @override
  _TLDCreatingPursePageState createState() => _TLDCreatingPursePageState();
}


class _TLDCreatingPursePageState extends State<TLDCreatingPursePage> {

  TLDCreatePurseModelManager _manager;
  @override
  void initState() { 
    super.initState();
    _manager = TLDCreatePurseModelManager();

    _createPurse();
  }

  Future _createPurse()async{
    await _manager.createPurse('', (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => TLDCreatePurseSuccessPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'creating_purse_page',
        transitionBetweenRoutes: false,
        middle: Text('创建钱包'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body:  _getBodyWidget(context),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }


  Widget _getBodyWidget(BuildContext context){
    return Center(
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(250)),
            child: Image.asset('assetss/images/creating_purse.png',width: ScreenUtil().setWidth(176),height: ScreenUtil().setHeight(212),),
          ),
          Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(68)),
            child: Text('钱包创建中，请您耐心等待……',style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51))),
          )
        ],
      )
    );
  }
}