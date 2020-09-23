import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TLDAAAFriendTeamOpenCell extends StatefulWidget {
  TLDAAAFriendTeamOpenCell({Key key,this.didClickOpenItem}) : super(key: key);

  final Function didClickOpenItem;

  @override
  _TLDAAAFriendTeamOpenCellState createState() => _TLDAAAFriendTeamOpenCellState();
}

class _TLDAAAFriendTeamOpenCellState extends State<TLDAAAFriendTeamOpenCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setHeight(20)),
      child: Container(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
        width: MediaQuery.of(context).size.width - ScreenUtil().setWidth(60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Colors.white),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  top: ScreenUtil().setHeight(20)),
              child: _getHeaderRowView(),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: Divider(
                height: ScreenUtil().setHeight(2),
                color: Color.fromARGB(255, 219, 218, 216),
              ),
            ),
           Padding(padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20),
                  top: ScreenUtil().setHeight(20)),
                  child: 1 > 0 ? _getGridView() : Text('暂无数据',style : TextStyle(color : Color.fromARGB(255, 51, 51, 51),fontSize : ScreenUtil().setSp(28)))),
           GestureDetector(
             onTap:widget.didClickOpenItem,
             child : Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.black,
              ),
            )
           )
          ],
        ),
      ),
    );
  }

  Widget _getGridView() {
    return GridView.builder(
        physics: new NeverScrollableScrollPhysics(), //增加
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 2,
            crossAxisSpacing: ScreenUtil().setWidth(10),
            mainAxisSpacing: ScreenUtil().setHeight(10)),
        itemCount: 12,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap :(){

            },
            child :_getGridItem(index)
          );
        });
  }

  Widget _getGridItem(int index){
    return Container(
      height : ScreenUtil().setHeight(72),
       decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Theme.of(context).hintColor),
        child: Center(
          child: Text('321312',style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromARGB(255, 143, 110, 68)),
        ),
        )
    );
  }

  Widget _getHeaderRowView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(text: TextSpan(
          children : <InlineSpan>[
             WidgetSpan(
                    child : CachedNetworkImage(imageUrl: 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3303266263,407158830&fm=26&gp=0.jpg',width: ScreenUtil().setSp(48),height: ScreenUtil().setSp(48),fit: BoxFit.fill,),
                  ),
             TextSpan(
               text : '  团队',
               style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color.fromARGB(255, 51, 51, 51))
             )
          ]
        )),
        Text(
              '100人',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ],
        );
  }
}