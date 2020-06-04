import 'package:flutter_qr_reader/qrcode_reader_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';


class TLDScanQrCodePage extends StatefulWidget {
  TLDScanQrCodePage({Key key,this.scanCallBack}) : super(key: key);

  final Function(String) scanCallBack;

  @override
  _TLDScanQrCodePageState createState() => _TLDScanQrCodePageState();
}

class _TLDScanQrCodePageState extends State<TLDScanQrCodePage> {

  GlobalKey<QrcodeReaderViewState> qrViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          color : Color.fromARGB(0, 0, 0, 0),
        ),
        heroTag: 'qr_scan_page',
        transitionBetweenRoutes: false,
        middle: Text('扫一扫'),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        actionsForegroundColor: Color.fromARGB(255, 51, 51, 51),
      ),
      body: QrcodeReaderView(key: qrViewKey, onScan: (String result)async{
        await widget.scanCallBack(result);
        Navigator.of(context).pop();
      }),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
    );
  }

}