import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

abstract class PartnerRepository {
  Future<List<UserProfile>> getPublicProfiles();
}
