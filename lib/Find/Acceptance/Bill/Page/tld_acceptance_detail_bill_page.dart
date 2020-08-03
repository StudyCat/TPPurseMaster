import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/CommonWidget/tld_web_page.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Bill/View/tld_acceptance_detail_bill_view.dart';
import 'package:dragon_sword_purse/Find/Acceptance/Order/Model/tld_acceptance_detail_order_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';


class TLDAcceptanceDetailBillPage extends StatefulWidget {
  TLDAcceptanceDetailBillPage({Key key,this.orderNo}) : super(key: key);

  final String orderNo;

  @override
  _TLDAcceptanceDetailBillPageState createState() => _TLDAcceptanceDetailBillPageState();
}

class _TLDAcceptanceDetailBillPageState extends State<TLDAcceptanceDetailBillPage> {
  TLDAcceptanceDetailOrderModelManager _modelManager;

  bool _isLoading = true;

  TLDAcceptanceDetailOrderInfoModel _detailOrderInfoModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
    _modelManager = TLDAcceptanceDetailOrderModelManager();
    
    _getDetailInfo();

  }

  void _getDetailInfo(){
    if(mounted){
      setState(() {
      _isLoading = true;
    });
    }
    _modelManager.getDetailOrderInfo(widget.orderNo, (TLDAcceptanceDetailOrderInfoModel infoModel){
      if(mounted){
      setState(() {
      _isLoading = false;
      _detailOrderInfoModel = infoModel;
    });
    }
    }, (TLDError error){
      if(mounted){
      setState(() {
      _isLoading = false;
    });
    Fluttertoast.showToast(msg: error.msg);
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'acceptance_detail_bill_page',
        transitionBetweenRoutes: false,
        middle: Text('TLD票据订单详情',style: TextStyle(color:Colors.white),),
        trailing: IconButton(icon: Icon(IconData(0xe614,fontFamily : 'appIconFonts')), onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder : (context) => TLDWebPage(urlStr: 'http://128.199.126.189:8080/desc/bill_desc.html',title: '票据说明',)));
        }),
        backgroundColor: Theme.of(context).primaryColor,
        actionsForegroundColor: Colors.white,
      ),
      body: LoadingOverlay(isLoading: _isLoading,child: _getBody(),),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

  Widget _getBodyWidget(){
    if (_detailOrderInfoModel == null){
      return Container();
    }else{
      return TLDAcceptanceDetailBillView(detailOrderInfoModel: _detailOrderInfoModel,);
    }
  }

  Widget _getBody(){
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(60),
          color: Theme.of(context).primaryColor,
        ),
        _getBodyWidget()
      ],
    );
  }

}