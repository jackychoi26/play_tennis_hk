import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/profile/data/user_profile_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/token_provider.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/user_profile_repository.dart';

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier(
    this.userProfileRepository,
    this.tokenNotifier,
  ) : super(null);

  UserProfileRepository userProfileRepository;

  TokenNotifier tokenNotifier;

  Future<void> register(UserProfile userProfile) async {
    final (newUserProfile, accessToken) =
        await userProfileRepository.register(userProfile);

    final bearerAccessToken = "Bearer $accessToken";

    tokenNotifier.storeAccessToken(bearerAccessToken);

    userProfileRepository.storeUserProfile(userProfile);

    state = newUserProfile;
  }

  Future<void> login(String username, String password) async {
    final (userProfile, accessToken) = await userProfileRepository
        .getAuthenticationSession(username, password);

    final bearerAccessToken = "Bearer $accessToken";

    tokenNotifier.storeAccessToken(bearerAccessToken);

    userProfileRepository.storeUserProfile(userProfile);

    state = userProfile;
  }

  void logout() {
    tokenNotifier.removeAccessToken();
    userProfileRepository.removeUserProfile();
    state = null;
  }

  Future<void> loadUserProfile() async {
    await tokenNotifier.getAccessToken();

    if (tokenNotifier.state == null) {
      logout();
    }

    final userProfile = await userProfileRepository.getUserProfile();
    state = userProfile;
  }

  Future<void> editProfile(UserProfile userProfile) async {
    final updatedUserProfile =
        await userProfileRepository.updateUserProfile(userProfile);

    userProfileRepository.storeUserProfile(updatedUserProfile);

    state = updatedUserProfile;
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
  final tokenNotifier = ref.watch(tokenProvider.notifier);

  return UserProfileNotifier(
    UserProfileRepositoryImpl(),
    tokenNotifier,
  );
});
