import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/profile/data/token_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/data/user_profile_repository.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/token_repository.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/user_profile_provider.dart';

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier(
    this.userProfileRepository,
    this.tokenRepository,
  ) : super(null);

  UserProfileRepository userProfileRepository;
  TokenRepository tokenRepository;

  void register(UserProfile userProfile) {}

  void login(String username, String password) async {
    final (userProfile, accessToken) = await userProfileRepository
        .getAuthenticationSession(username, password);

    tokenRepository.storeAccessToken(accessToken);
    userProfileRepository.storeUserProfile(userProfile);
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
  return UserProfileNotifier(
    UserProfileRepositoryImpl(),
    TokenRepositoryImpl(),
  );
});
