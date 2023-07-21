import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

abstract class UserProfileRepository {
  Future<(UserProfile, String)> getAuthenticationSession(
      String username, String password);
  Future<void> register(UserProfile userProfile);
  Future<void> storeUserProfile(UserProfile userProfile);
  Future<UserProfile> getUserProfile();
  Future<void> updateUserProfile(UserProfile userProfile);
  Future<void> removeUserProfile();
}
