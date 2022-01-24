import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

String stringEncryptAES({required String data}) {
  String encrypted = encryptAESCryptoJS(data, '914cf752-f9d5-11ea-8e66-f8cab84cf539');
  return encrypted;
}

String stringEncryptAESSingle({required String data, required String token}) {
  String encrypted = encryptAESCryptoJS(data, token);
  return encrypted;
}

String stringDecryptAESSingle({required String data, required String token}) {
  String encrypted = decryptAESCryptoJS(data, token);
  return encrypted;
}

String stringDecryptAES({required String data}) {
  String decrypted = decryptAESCryptoJS(data, '914cf752-f9d5-11ea-8e66-f8cab84cf539');
  return decrypted;
}

String mapEncryptAES({required Map<String, dynamic> data}) {
  String rawJson = jsonEncode(data);
  debugPrint("data raw request sebelum encrypt: $rawJson");
  String encrypted = encryptAESCryptoJS(rawJson, '914cf752-f9d5-11ea-8e66-f8cab84cf539');
  return encrypted;
}

String encryptAESCryptoJS(String plainText, String passphrase) {
  try {
    final salt = genRandomWithNonZero(8);
    var keyAndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyAndIV.item1);
    final iv = encrypt.IV(keyAndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        createUint8ListFromString("Salted__") + salt + encrypted.bytes);
    return base64.encode(encryptedBytesWithSalt);
  } catch (error) {
    throw error;
  }
}

String decryptAESCryptoJS(String encrypted, String passphrase) {
  try {
    Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

    Uint8List encryptedBytes =
    encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
    final salt = encryptedBytesWithSalt.sublist(8, 16);
    var keyAndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyAndIV.item1);
    final iv = encrypt.IV(keyAndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final decrypted =
    encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
    return decrypted;
  } catch (error) {
    throw error;
  }
}

Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  var password = createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    // int preHashLength = currentHash.length + password.length + salt.length;
    if (currentHash.length > 0)
      preHash = Uint8List.fromList(currentHash + password + salt);
    else
      preHash = Uint8List.fromList(password + salt);

    currentHash = Uint8List.fromList(md5.convert(preHash).bytes);
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
  }

  var keyBytes = concatenatedHashes.sublist(0, 32);
  var ivBytes = concatenatedHashes.sublist(32, 48);
  return new Tuple2(keyBytes, ivBytes);
}

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

Uint8List genRandomWithNonZero(int seedLength) {
  final random = Random.secure();
  const int randomMax = 245;
  final Uint8List uint8list = Uint8List(seedLength);
  for (int i = 0; i < seedLength; i++) {
    uint8list[i] = random.nextInt(randomMax) + 1;
  }
  return uint8list;
}



// import 'dart:convert';
// import 'dart:ffi';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:crypto/crypto.dart';
// import 'package:tuple/tuple.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
//
// Uint8List createUin8ListFromString(String s){
//   var ret = Uint8List(s.length);
//   for(int i=0;i<s.length; i++){
//     ret[i] = s.codeUnitAt(i);
//   }
//
//   return ret;
// }
//
// Uint8List getRandomWithNonZero(int seedLength){
//   final random = Random.secure();
//   const int randomMax= 245;
//   final Uint8List uint8list = Uint8List(seedLength);
//   for(int i = 0; i<seedLength;i++){
//     uint8list[i] = random.nextInt(randomMax) + 1;
//   }
//
//   return uint8list;
// }
//
// Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt){
//   var password= createUin8ListFromString(passphrase);
//   Uint8List concatenedHashes = Uint8List(0);
//   Uint8List currentHash = Uint8List(0);
//   bool enoughBytesForKey = false;
//   Uint8List preHash = Uint8List(0);
//
//   while(!enoughBytesForKey){
//     if(currentHash.length > 0){
//       preHash =  Uint8List.fromList(currentHash + password + salt);
//     }else{
//       preHash = Uint8List.fromList(password + salt);
//     }
//
//     currentHash = Uint8List.fromList(md5.convert(preHash).bytes);
//     concatenedHashes = Uint8List.fromList(concatenedHashes + currentHash);
//     if(concatenedHashes.length >= 48) enoughBytesForKey = true;
//   }
//
//   var keyBytes = concatenedHashes.sublist(0,32);
//   var ivBytes = concatenedHashes.sublist(32,48);
//   return new Tuple2(keyBytes, ivBytes);
// }
//
// String decryptAESCryptoJS(String encrypted, String passphrase){
//   try{
//     Uint8List encryptedByetesWithSalt = base64.decode(encrypted);
//
//     Uint8List encryptedBytes = encryptedByetesWithSalt.sublist(16, encryptedByetesWithSalt.length);
//     final salt = encryptedByetesWithSalt.sublist(8,16);
//     var keyAndIV = deriveKeyAndIV(passphrase, salt);
//     final key = encrypt.Key(keyAndIV.item1);
//     final iv = encrypt.IV(keyAndIV.item2);
//
//     final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
//     final decrypted = encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
//     return decrypted;
//   }catch(e){
//     throw e;
//   }
// }
//
// String encryptAESCryptoJS(String plainText, String passphrase){
//   try{
//     final salt = getRandomWithNonZero(8);
//     var keyAndIV= deriveKeyAndIV(passphrase, salt);
//     final key = encrypt.Key(keyAndIV.item1);
//     final iv = encrypt.IV(keyAndIV.item2);
//     print(plainText);
//
//     final encrypter = encrypt.Encrypter(
//       encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7")
//     );
//     final encrypted = encrypter.encrypt(plainText, iv: iv);
//     Uint8List encryptedtBytesWithSalt = Uint8List.fromList(
//       createUin8ListFromString("Salted__") + salt + encrypted.bytes
//     );
//     return base64.encode(encryptedtBytesWithSalt);
//   }catch(e){
//     throw e;
//   }
// }
//
// String stringDecryptAES({required String data}){
//   String decrypted = decryptAESCryptoJS(data, '914cf752-f9d5-11ea-8e66-f8cab84cf539');
//   return decrypted;
// }
//
// String stringEncryptAES({required String data}){
//   String encrypted = encryptAESCryptoJS(data, '914cf752-f9d5-11ea-8e66-f8cab84cf539');
//   return encrypted;
// }