import 'package:descrypto/src/util.dart';
import 'package:flutter/services.dart';

import 'ffi.dart';

class DesCrypt {
  static const MethodChannel _channel = const MethodChannel('descrypto');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String encode(String key, String input) {
    final keyUint8 = Utils.stringToBytesUtf8(key);
    final inputUint8 = Utils.hexToBytes(input);
    final result = desEncode(keyUint8, inputUint8);
    return Utils.byteToHex(result);
  }

  static String decode(String key, String input) {
    final keyUint8 = Utils.stringToBytesUtf8(key);
    final inputUint8 = Utils.hexToBytes(input);
    final result = desDecode(keyUint8, inputUint8);
    return Utils.byteToHex(result);
  }
}
