import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:descrypto/descrypto.dart';
import 'package:ffi/ffi.dart';

final DynamicLibrary desLib = Platform.isAndroid
    ? DynamicLibrary.open("libdes.so")
    : DynamicLibrary.process();

typedef DesNativeFuc = Void Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>);
typedef DesFlutterFuc = void Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>);

// void des_encode(unsigned char des_key[8], unsigned char *in, unsigned char *out);
final DesFlutterFuc nativeDesEncode =
    desLib.lookup<NativeFunction<DesNativeFuc>>("des_encode").asFunction();

//  void des_decode(unsigned char des_key[8], unsigned char *in, unsigned char *out);
final DesFlutterFuc nativeDesDecode =
    desLib.lookup<NativeFunction<DesNativeFuc>>("des_decode").asFunction();

typedef DesNativeFuc2 = Void Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Uint8);
typedef DesFlutterFuc2 = void Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int);

// void des_encode(unsigned char des_key[8], unsigned char *in, unsigned char *out);
final DesFlutterFuc2 nativeDesEncode2 =
    desLib.lookup<NativeFunction<DesNativeFuc2>>("des_encode_var").asFunction();

//  void des_decode(unsigned char des_key[8], unsigned char *in, unsigned char *out);
final DesFlutterFuc2 nativeDesDecode2 =
    desLib.lookup<NativeFunction<DesNativeFuc2>>("des_decode_var").asFunction();

// Copy byte array to native heap
Pointer<Uint8> _bytesToPointer(Uint8List bytes) {
  final length = bytes.length;
  final result = allocate<Uint8>(count: length);
  for (var i = 0; i < length; ++i) {
    result[i] = bytes[i];
  }
  return result;
}

//Uint8List desEncode(Uint8List key, Uint8List input) {
//  final keyPrt = _bytesToPointer(key);
//  final inputPtr = _bytesToPointer(input);
//  int length = input.length;
//  final result = allocate<Uint8>(count: length);
//  nativeDesEncode(keyPrt, inputPtr, result);
//  return result.asTypedList(length);
//}
//
//Uint8List desDecode(Uint8List key, Uint8List input) {
//  final keyPrt = _bytesToPointer(key);
//  final inputPtr = _bytesToPointer(input);
//  int length = input.length;
//  final result = allocate<Uint8>(count: length);
//  nativeDesDecode(keyPrt, inputPtr, result);
//  return result.asTypedList(length);
//}

Uint8List desEncode(Uint8List key, Uint8List input) {
  final keyPrt = _bytesToPointer(key);
  final inputPtr = _bytesToPointer(input);
  int length = input.length;
  final result = allocate<Uint8>(count: length);
  final resultLen = allocate<Uint8>(count: 1);
  nativeDesEncode2(keyPrt, result, resultLen, inputPtr, length);
  return result
      .asTypedList(resultLen.value);
}

Uint8List desDecode(Uint8List key, Uint8List input) {
  final keyPrt = _bytesToPointer(key);
  final inputPtr = _bytesToPointer(input);
  int length = input.length;
  final resultLen = allocate<Uint8>(count: 1);
  final result = allocate<Uint8>(count: length);
  nativeDesDecode2(keyPrt, result, resultLen, inputPtr, length);
  return result
      .asTypedList(resultLen.value);
}
