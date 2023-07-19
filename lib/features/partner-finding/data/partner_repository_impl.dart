import 'package:play_tennis_hk/domain/district.dart';
import 'package:play_tennis_hk/features/partner-finding/domain/repositories/partner_repository.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class PartnersRepositoryImpl implements PartnerRepository {
  @override
  Future<List<UserProfile>> getPublicProfiles() async {
    await Future.delayed(const Duration(seconds: 2));

    return [
      const UserProfile(
        username: "Hemingway",
        email: "hemingway@gmail.com",
        districts: [District.centralAndWestern],
        ntrpLevel: 3.5,
      ),
      const UserProfile(
        username: "SteveJobs",
        email: "SteveJobs@apple.com",
        districts: [District.north],
        ntrpLevel: 4,
        description: "Hello Testing",
      ),
    ];
  }
}
