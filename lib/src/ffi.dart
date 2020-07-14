import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:descrypto/descrypto.dart';
import 'package:ffi/ffi.dart';

final DynamicLibrary desLib = Platform.isAndroid
    ? DynamicLibrary.open("libdes.so")
    : DynamicLibrary.process();

typedef DesNativeFuc = Void Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Uint8);
typedef DesFlutterFuc = void Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int);

// void des_encode_var(unsigned char *des_key, unsigned char *dest, unsigned char *dest_len, unsigned char *src, unsigned char src_len);
final DesFlutterFuc nativeDesEncode =
    desLib.lookup<NativeFunction<DesNativeFuc>>("des_encode_var").asFunction();

// void des_decode_var(unsigned char *des_key, unsigned char *dest, unsigned char *dest_len, unsigned char *src, unsigned char src_len);
final DesFlutterFuc nativeDesDecode =
    desLib.lookup<NativeFunction<DesNativeFuc>>("des_decode_var").asFunction();

// Copy byte array to native heap
Pointer<Uint8> _bytesToPointer(Uint8List bytes) {
  final length = bytes.length;
  final result = allocate<Uint8>(count: length);
  for (var i = 0; i < length; ++i) {
    result[i] = bytes[i];
  }
  return result;
}

Uint8List desEncode(Uint8List key, Uint8List input) {
  final keyPrt = _bytesToPointer(key);
  final inputPtr = _bytesToPointer(input);
  int length = input.length;
  final result = allocate<Uint8>(count: length);
  final resultLen = allocate<Uint8>(count: 1);
  nativeDesEncode(keyPrt, result, resultLen, inputPtr, length);
  return result.asTypedList(resultLen.value);
}

Uint8List desDecode(Uint8List key, Uint8List input) {
  final keyPrt = _bytesToPointer(key);
  final inputPtr = _bytesToPointer(input);
  int length = input.length;
  final resultLen = allocate<Uint8>(count: 1);
  final result = allocate<Uint8>(count: length);
  nativeDesDecode(keyPrt, result, resultLen, inputPtr, length);
  return result.asTypedList(resultLen.value);
}
