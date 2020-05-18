import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../View/tld_order_list_cell.dart';
import 'tld_detail_order_page.dart';
import '../../IM/Page/tld_im_page.dart';


class TLDOrderListContentPage extends StatefulWidget {
  TLDOrderListContentPage({Key key}) : super(key: key);

  @override
  _TLDOrderListContentPageState createState() => _TLDOrderListContentPageState();
}

class _TLDOrderListContentPageState extends State<TLDOrderListContentPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      itemBuilder: (context ,index) => _getListItem(context, index) 
      );
  }

  Widget _getListItem(BuildContext context,int index){
    return TLDOrderListCell(
      didClickDetailBtnCallBack: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => TLDDetailOrderPage()));
        },
      didClickIMBtnCallBack: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TLDIMPage()));
      },
      );
  }
}