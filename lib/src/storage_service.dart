import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class StorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() => _instance;

  late final GetStorage _box;
  final String _encryptionKey = 'my32lengthsupersecretnooneknows!';

  late final encrypt.Encrypter _encrypter;
  late final encrypt.IV _iv;

  StorageService._internal() {
    _box = GetStorage();
    final key = encrypt.Key.fromUtf8(_encryptionKey);
    _iv = encrypt.IV.fromLength(16);
    _encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  static Future<void> init() async {
    await GetStorage.init();
  }

  void saveString(String key, String value) {
    _box.write(key, value);
  }

  String? getString(String key) {
    return _box.read<String>(key);
  }

  void remove(String key) {
    _box.remove(key);
  }

  void clear() {
    _box.erase();
  }

  void saveEncryptedString(String key, String value) {
    final encrypted = _encrypter.encrypt(value, iv: _iv);
    _box.write(key, encrypted.base64);
  }

  String? getEncryptedString(String key) {
    final encryptedBase64 = _box.read<String>(key);
    if (encryptedBase64 == null) return null;
    try {
      final encrypted = encrypt.Encrypted.fromBase64(encryptedBase64);
      debugPrint("encryted: $encryptedBase64");
      final decrypted = _encrypter.decrypt(encrypted, iv: _iv);
      return decrypted;
    } catch (e) {
      print('Decryption error for key [$key]: $e');
      return null;
    }
  }
}
