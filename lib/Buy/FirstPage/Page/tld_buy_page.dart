import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dragon_sword_purse/Purse/FirstPage/View/message_button.dart';
import '../View/tld_buy_search_field.dart';
import '../View/tld_buy_firstpage_cell.dart';

class TLDBuyPage extends StatefulWidget {
  TLDBuyPage({Key key}) : super(key: key);

  @override
  _TLDBuyPageState createState() => _TLDBuyPageState();
}

class _TLDBuyPageState extends State<TLDBuyPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _getBodyWidget(size.width),
      appBar: CupertinoNavigationBar(
        middle: Text('TLD钱包'),
        leading: Builder(builder: (BuildContext context) {
          return CupertinoButton(
              child: Icon(
                IconData(0xe608, fontFamily: 'appIconFonts'),
                color: Color.fromARGB(255, 51, 51, 51),
              ),
              padding: EdgeInsets.all(0),
              minSize: 20,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        automaticallyImplyLeading: false,
        trailing: Container(
          width : 80,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(
                child: Icon(
                  IconData(0xe663, fontFamily: 'appIconFonts'),
                  color: Color.fromARGB(255, 51, 51, 51),
                ),
                padding: EdgeInsets.all(0),
                minSize: 20,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
            MessageButton()
          ],
        )
        ),
      ),
    );
  }

  Widget _getBodyWidget(double screenWidth){
    return Container(
      padding: EdgeInsets.all(0),
      width: screenWidth,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TLDBuySearchField(),
        Container(
          height : 120,
          child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
          return TLDBuyFirstPageCell();
         },
        ), 
        ),
      ],
    ),
    );
  }

}
