import 'dart:convert';

import 'package:play_tennis_hk/features/profile/data/webservices/login_webservice.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  UserProfileRepositoryImpl();
  @override
  Future<(UserProfile, String)> getAuthenticationSession(
      String username, String password) async {
    final loginData = {
      "username": username,
      "password": password,
    };

    final loginWebservice = LoginWebservice();

    final loginResponse = await loginWebservice.performRequest(loginData);
    final userProfile = loginResponse.userProfile;
    final accessToken = loginResponse.accessToken;

    return (userProfile, accessToken);
  }

  @override
  Future<void> register(UserProfile userProfile) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> storeUserProfile(UserProfile userProfile) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("userProfile", jsonEncode(userProfile.toJson()));

    return;
  }

  @override
  Future<UserProfile> getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final userProfileCache = await prefs.getString("userProfile");

    final UserProfile userProfile;

    if (userProfileCache == null) {
      //TODO: get from server
      throw Exception("No user profile found");
    } else {
      userProfile = UserProfile.fromJson(jsonDecode(userProfileCache));
    }

    return userProfile;
  }

  @override
  Future<void> removeUserProfile() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove("userProfile");
  }
}
