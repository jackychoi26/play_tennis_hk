import 'package:play_tennis_hk/features/partner-finding/data/webservices/partners_webservice.dart';
import 'package:play_tennis_hk/features/partner-finding/domain/repositories/partner_repository.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class PartnersRepositoryImpl implements PartnerRepository {
  final partnersWebservice = PartnersWebservice();

  @override
  Future<List<UserProfile>> getPublicProfiles() async {
    final partnerResponse = await partnersWebservice.performRequest();
    return partnerResponse.userProfiles;
  }
}
