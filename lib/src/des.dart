import 'package:descrypto/src/util.dart';

import 'ffi.dart';

class DesCrypt {
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
