import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<(UserProfile, String)> getAuthenticationSession(
      String username, String password);
  Future<(UserProfile, String)> register(UserProfile userProfile);
  Future<void> storeUserProfile(UserProfile userProfile);
  Future<UserProfile> getUserProfile();
  Future<UserProfile> updateUserProfile(UserProfile userProfile);
  Future<void> removeUserProfile();
}
