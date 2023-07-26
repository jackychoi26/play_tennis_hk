import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: "accessToken");
  }

  @override
  Future<void> storeAccessToken(String token) async {
    return await secureStorage.write(key: "accessToken", value: token);
  }

  @override
  Future<void> removeAccessToken() async {
    return await secureStorage.delete(key: "accessToken");
  }
}
