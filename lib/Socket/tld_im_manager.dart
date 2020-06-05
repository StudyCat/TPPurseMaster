
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

class TLDIMManager{

  factory TLDIMManager(String walletAddress) =>_getInstance();
  static TLDIMManager get instance => _getInstance();
  static TLDIMManager _instance;

  String walletAddress;


  TLDIMManager._internal() {
    // 初始化

  }

  Future<IOWebSocketChannel> connectClient() async{
    var channel = IOWebSocketChannel.connect("ws://192.168.1.120:8030/webSocket/"+ this.walletAddress);

    channel.stream.listen((message) { 
      
    });
  }


  static TLDIMManager _getInstance() {
    if (_instance == null) {
      _instance = new TLDIMManager._internal();
    }
    return _instance;
  }

  
  }
