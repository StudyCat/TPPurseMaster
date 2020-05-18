import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TLDImageShowPage extends StatefulWidget {
  TLDImageShowPage(
      {Key key, this.images, this.pageController, this.heroTag, this.index,this.isShowDelete,this.deleteCallBack})
      : super(key: key);

  final images;
  int index = 0;
  String heroTag;
  final PageController pageController;
  bool isShowDelete = true;
  final ValueChanged<int> deleteCallBack;
  @override
  _TLDImageShowPageState createState() => _TLDImageShowPageState();
}

class _TLDImageShowPageState extends State<TLDImageShowPage> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: Image.file(widget.images[index]).image,
                  heroAttributes: widget.heroTag.isNotEmpty
                      ? PhotoViewHeroAttributes(tag: widget.heroTag)
                      : null,
                );
              },
              itemCount: widget.images.length,
              backgroundDecoration: null,
              pageController: widget.pageController,
              enableRotation: true,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            )),
          ),
          Positioned(
            //图片index显示
            top: MediaQuery.of(context).padding.top + 15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex + 1}/${widget.images.length}",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          Positioned(
            //右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          widget.isShowDelete == true ? Positioned(
            //右上角删除按钮
            left: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.delete,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                widget.deleteCallBack(currentIndex);
                Navigator.of(context).pop();
              },
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
