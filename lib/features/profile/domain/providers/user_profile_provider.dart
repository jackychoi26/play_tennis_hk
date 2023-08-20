import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/domain/district.dart';
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

  Future<void> editProfile({
    String? password,
    String? email,
    String? imageUrl,
    num? ntrpLevel,
    int? age,
    String? description,
    List<District>? districts,
    String? telegram,
    String? signal,
    String? whatsapp,
    bool? isProfilePublic,
    bool? notifyBadWeather,
  }) async {
    Map<String, dynamic> result = {};

    if (password != null) result['password'] = password;
    if (email != null) result['email'] = email;
    if (imageUrl != null) result['imageUrl'] = imageUrl;
    if (ntrpLevel != null) result['ntrpLevel'] = ntrpLevel;
    if (age != null) result['age'] = age;
    if (description != null) result['description'] = description;

    if (districts != null) {
      result['districts'] = districts.map((e) => e.toKey()).toList();
    }

    if (telegram != null) result['telegram'] = telegram;
    if (signal != null) result['signal'] = signal;
    if (whatsapp != null) result['whatsapp'] = whatsapp;
    if (isProfilePublic != null) result['isProfilePublic'] = isProfilePublic;
    if (notifyBadWeather != null) result['notifyBadWeather'] = notifyBadWeather;

    final updatedUserProfile = await userProfileRepository.updateUserProfile(
      result,
    );

    userProfileRepository.storeUserProfile(updatedUserProfile);

    state = updatedUserProfile;
  }

  Future<void> deleteAccount() async {
    await userProfileRepository.deleteAccount();

    logout();
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
