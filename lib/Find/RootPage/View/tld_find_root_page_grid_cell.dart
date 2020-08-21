import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDFindRootPageGridCell extends StatefulWidget {
  TLDFindRootPageGridCell({Key key,this.itemUIModel}) : super(key: key);

  final TLDFindRootCellUIItemModel itemUIModel;

  @override
  _TLDFindRootPageGridCellState createState() => _TLDFindRootPageGridCellState();
}

class _TLDFindRootPageGridCellState extends State<TLDFindRootPageGridCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children : <Widget>[
        _getImageWidget(),
        Offstage(
          offstage: widget.itemUIModel.isPlusIcon,
          child: Padding(
            padding: EdgeInsets.only(top : ScreenUtil().setHeight(12)),
            child: Text(widget.itemUIModel.title,style:TextStyle(color:Color.fromARGB(255, 51, 51, 51),fontSize: ScreenUtil().setSp(24))),
          ),
        )
      ]
    );
  }

  Widget _getImageWidget(){
    if (widget.itemUIModel.isPlusIcon == false){
      if (widget.itemUIModel.iconUrl.length > 0){
        return CachedNetworkImage(imageUrl: widget.itemUIModel.iconUrl,width:ScreenUtil().setHeight(96),height:ScreenUtil().setHeight(96),fit: BoxFit.fill,);
      }else{
      return Image.asset(widget.itemUIModel.imageAssest,width:ScreenUtil().setHeight(96),height:ScreenUtil().setHeight(96),fit: BoxFit.fill,);
      }
    }else{
      return Icon(IconData(0xe67e,fontFamily:'appIconFonts'),size: ScreenUtil().setHeight(96), color: Color.fromARGB(255, 153, 153, 153),);
    }
  }

}