import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';

import 'key_manager.dart';

// This class Manage the Encryption and Password Hashing
class Cryption {
  final Cipher _cipher = aesGcm;
  var encrypted;

  // Encrypt every TCP Message which is send to the PI
  Future<String> encrypt(msg) async {
    SecretKey secretKey = await KeyManager().secretKey;
    var tempMsg = utf8.encode(msg);
    Nonce nonce = _cipher.newNonce();
    final encrypted = await _cipher.encrypt(
      tempMsg,
      secretKey: secretKey,
      nonce: nonce,
    );
    Uint8List uint8nonce = nonce.bytes;
    final hexNonce = hex.encode(uint8nonce);
    final encryptedHex = hex.encode(encrypted);
    final encryptedHexNonce = '$encryptedHex;$hexNonce';
    return encryptedHexNonce;
  }

  // Hash the User Password with PBKDF2 Algorithm
  Future<List<int>> passwordHash(String password, Nonce nonce) async {
    if (nonce == null) {
      nonce = _cipher.newNonce();
      KeyManager().safePasswordNonce(nonce);
    }
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac(sha256),
      iterations: 5000,
      bits: 128,
    );
    final hashPassword =
        await pbkdf2.deriveBits(utf8.encode(password), nonce: nonce);
    return hashPassword;
  }
}
