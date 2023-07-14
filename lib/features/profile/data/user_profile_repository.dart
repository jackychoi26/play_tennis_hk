import 'dart:io';
import 'package:dio/dio.dart';
import 'package:play_tennis_hk/features/profile/data/webservices/login_response.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/user_profile_provider.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  UserProfileRepositoryImpl();

  final _dio = Dio(BaseOptions(baseUrl: "http://localhost:3000", headers: {
    HttpHeaders.contentTypeHeader: "application/json",
  }));

  @override
  Future<(UserProfile, String)> login(String username, String password) async {
    final loginData = FormData.fromMap({
      "username": username,
      "password": password,
    });

    final response = await _dio.post("/profile", data: loginData);

    if (response.statusCode == 200) {
      final data = LoginResponse.fromJson(response.data);
      final userProfile = data.userProfile;
      final accessToken = data.accessToken;

      return (userProfile, accessToken);
    } else {
      throw Error();
    }
  }

  @override
  Future<void> register(UserProfile userProfile) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> storeUserProfile(UserProfile userProfile) {
    // TODO: implement storeUserProfile
    throw UnimplementedError();
  }
}
