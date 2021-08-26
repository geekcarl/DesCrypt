import 'package:descrypto/descrypto.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  print(
      "================================================================================");
  var enc = DesCrypt.encode("TTMJ_234", "12345678");
  print("enc ========== $enc");
  print("dec ========== ${DesCrypt.decode("TTMJ_234", enc)}");
  print(
      "================================================================================");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String key = "TTMJ_234";
  var testStr = "12345678";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Text('加密：$testStr'),
            Text('${DesCrypt.encode(key, testStr)}'),
            Text('解密：'),
            Text('${DesCrypt.decode(key, DesCrypt.encode(key, testStr))}'),
            Text(
                '${DesCrypt.decode("SDtt6789", "0F2FC71128FCD76396555E04E67FE8DEC4482AFA28B5EC9A608369F30F465E14")}'),
            Text(
                '${DesCrypt.decode("SDtt6789", "0B5E1EBD0AD54D335412ED77FCA15D22")}'),
            Text(
                '${DesCrypt.decode("wocaonima", DesCrypt.encode("wocaonima", "0101010154544D4A5F333435FFFF0000"))}')
          ]),
        ),
      ),
    );
  }
}
