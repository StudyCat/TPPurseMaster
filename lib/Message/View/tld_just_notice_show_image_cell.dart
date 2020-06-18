
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class TLDJustNoticeShowImageCell extends StatefulWidget {
  TLDJustNoticeShowImageCell({Key key,this.title,this.images}) : super(key: key);

  final String title;

  final List images;

  @override
  _TLDJustNoticeShowImageCellState createState() => _TLDJustNoticeShowImageCellState();
}

class _TLDJustNoticeShowImageCellState extends State<TLDJustNoticeShowImageCell> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    num singleHeight = (size.width - ScreenUtil().setWidth(120)) / 3;
    num height = singleHeight + ScreenUtil().setHeight(100);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                child: RichText(
                  text: TextSpan(
                    text : widget.title,
                    style : TextStyle(fontSize : ScreenUtil().setSp(28),color : Color.fromARGB(255, 51, 51, 51)),
                    children: <InlineSpan>[
                      TextSpan(
                        text : '',
                        style: TextStyle(fontSize : ScreenUtil().setSp(24),color : Color.fromARGB(255, 153, 153, 153))
                      )
                    ],
                  ),
                )
              ),
                Container(
                      height: height,
                      padding: EdgeInsets.only(top : ScreenUtil().setHeight(40)),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: ScreenUtil().setWidth(10),
                            mainAxisSpacing: ScreenUtil().setHeight(10)),
                        itemCount: widget.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CachedNetworkImage(imageUrl:widget.images[index],fit : BoxFit.fill);
                        }),
                    )
            ]),
      ),
    );
  }
}