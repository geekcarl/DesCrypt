import 'package:descrypto/descrypto.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  print("================================================================================");
  var enc = DesCrypt.encode("TTMJ_234", "12345678");
  print("enc ========== $enc");
  print("dec ========== ${DesCrypt.decode("TTMJ_234", enc)}");
  print("================================================================================");

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  String key = "TTMJ_234";
  var testStr = "12345678";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await DesCrypt.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Text('Running on: $_platformVersion\n'),
            Text('加密：$testStr'),
            Text('${DesCrypt.encode(key, testStr)}'),
            Text('解密：'),
            Text('${DesCrypt.decode(key, DesCrypt.encode(key, testStr))}'),
            Text('${DesCrypt.decode("SDtt6789", "0F2FC71128FCD76396555E04E67FE8DEC4482AFA28B5EC9A608369F30F465E14")}'),
            Text('${DesCrypt.decode("SDtt6789", "0B5E1EBD0AD54D335412ED77FCA15D22")}'),
            Text('${DesCrypt.decode("wocaonima", DesCrypt.encode("wocaonima", "0101010154544D4A5F333435FFFF0000"))}')
          ]),
        ),
      ),
    );
  }
}
