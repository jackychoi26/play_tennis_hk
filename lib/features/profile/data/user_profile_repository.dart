import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfileRepository {
  UserProfileRepository();

  final secureStorage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: "accessToken");
  }
}
