import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/partner-finding/data/webservices/partners_response.dart';

class PartnersWebservice extends Webservice {
  Future<PartnersResponse> performRequest() async {
    final response = await dio.get('/profile/all');

    try {
      final publicProfiles = PartnersResponse.fromJson(response.data);
      return publicProfiles;
    } catch (err) {
      rethrow;
    }
  }
}
