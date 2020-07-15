import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TLDFindRootADBannerView extends StatefulWidget {
  TLDFindRootADBannerView({Key key}) : super(key: key);

  
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
          pagination: null,
          autoplay: true,
          loop: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: CachedNetworkImage(
                  imageUrl:
                      'http://img5.mtime.cn/CMS/News/2020/07/09/082832.97620660_620X620.jpg',
                  fit: BoxFit.fill),
            );
          },
        ),
      ),
    );
  }
}
