import 'package:play_tennis_hk/features/profile/data/webservices/login_webservice.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/user_profile_provider.dart';

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
  Future<void> storeUserProfile(UserProfile userProfile) {
    // TODO: implement storeUserProfile
    throw UnimplementedError();
  }
}
