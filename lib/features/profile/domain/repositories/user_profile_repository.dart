import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<void> storeUserProfile(UserProfile userProfile);
  Future<UserProfile> getUserProfile();
  Future<void> removeUserProfile();
  Future<void> register(UserProfile userProfile);
  Future<(UserProfile, String)> getAuthenticationSession(
      String username, String password);
}
