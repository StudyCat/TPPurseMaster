// import 'package:flutter/services.dart';


// class TLDClipboardData {
//   /// Creates data for the system clipboard.
//   const TLDClipboardData({this.text});

//   /// Plain text variant of this clipboard data.
//   final String text;
// }

// class TLDClipboard {
//   TLDClipboard._();


//   static const String kTextPlain = 'text/plain';

//   /// Stores the given clipboard data on the clipboard.
//   ///将ClipboardData中的内容复制的粘贴板
//   static Future<void> setData(ClipboardData data) async {
//     await SystemChannels.platform.invokeMethod<void>(
//       'Clipboard.setData',
//       <String, dynamic>{
//         'text': data.text,
//       },
//     );
//   }
// }