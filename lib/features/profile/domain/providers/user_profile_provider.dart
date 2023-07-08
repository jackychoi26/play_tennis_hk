import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier(super.state);

  void register(UserProfile userProfile) {}
}
