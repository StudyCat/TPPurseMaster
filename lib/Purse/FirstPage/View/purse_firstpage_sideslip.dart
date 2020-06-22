import 'package:dragon_sword_purse/Base/tld_base_request.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/Model/tld_purse_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'purse_sideslip_header_cell.dart';


class TLDPurseSideslipView extends StatefulWidget {
  TLDPurseSideslipView({Key key,this.didClickCallBack}) : super(key: key);

  final ValueChanged<int> didClickCallBack;

  @override
  _TLDPurseSideslipViewState createState() => _TLDPurseSideslipViewState();
}

class _TLDPurseSideslipViewState extends State<TLDPurseSideslipView> {

  List iconList = [0xe641,0xe672,0xe8ac,0xe665,0xe60e];
  List titleList = ['收款方式','积分兑换说明','反馈','关于我们','用户协议'];

  String _totalAmount;

  TLDPurseModelManager _manager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    _manager = TLDPurseModelManager();

    _totalAmount = '0.0';
    
    getTotalAmount();
  }

  void getTotalAmount(){
    _manager.getAllAmount((String total){
      if (mounted){
              setState(() {
        _totalAmount = total;
      });
      }
    }, (TLDError error){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        body: ListView.builder(
      itemCount: iconList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0){
          return TLDPurseSideSlipHeaderCell(totalAmount: _totalAmount);
        }else{
          return ListTile(
            leading : Container(
              padding : EdgeInsets.only(left: 35),
              child: Icon(IconData(iconList[index - 1],fontFamily: 'appIconFonts'),color: Color.fromARGB(255,51, 114, 255),),
            ),
            title: Text(titleList[index - 1],style : TextStyle(color : Color.fromARGB(255, 153, 153, 153),fontSize: 14),textAlign: TextAlign.left,),
            onTap: (){
              widget.didClickCallBack(index);
            },
          );
        }
     },
      ),
    ),
    );
  }
}

