import 'package:cached_network_image/cached_network_image.dart';
import 'package:dragon_sword_purse/Find/RootPage/Model/tld_find_root_model_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TLDFindRootADBannerView extends StatefulWidget {
  TLDFindRootADBannerView({Key key,this.bannerList,this.didClickBannerViewCallBack}) : super(key: key);

  final List bannerList;

  final Function(TLDBannerModel) didClickBannerViewCallBack;
  
  @override
  _TLDFindRootADBannerViewState createState() =>
      _TLDFindRootADBannerViewState();
}

class _TLDFindRootADBannerViewState extends State<TLDFindRootADBannerView> {
  @override
  Widget build(BuildContext context) {
    double height =
        (MediaQuery.of(context).size.width - ScreenUtil().setWidth(60)) /
            345 *
            170;
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
      child: Container(
        height: height,
        child: Swiper(
          key: UniqueKey(),
          pagination: null,
          autoplay: true,
          loop: true,
          itemCount: widget.bannerList.length,
          itemBuilder: (context, index) {
            TLDBannerModel bannerModel = widget.bannerList[index];
            return GestureDetector(
              onTap :() => widget.didClickBannerViewCallBack(bannerModel),
              child : ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: CachedNetworkImage(
                  imageUrl: bannerModel.bannerUrl
                      ,
                  fit: BoxFit.fill),
            )
            );
          },
        ),
      ),
    );
  }
}
