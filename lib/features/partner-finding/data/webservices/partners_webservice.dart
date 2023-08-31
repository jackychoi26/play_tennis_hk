import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/partner-finding/data/webservices/partners_response.dart';

class PartnersWebservice extends Webservice {
  Future<PartnersResponse> performRequest({required num offset}) async {
    final response = await dio.get(_getEndpoint(offset));

    try {
      final publicProfiles = PartnersResponse.fromJson(response.data);
      return publicProfiles;
    } catch (err) {
      rethrow;
    }
  }

  String _getEndpoint(num offset) {
    return "/profile/all?offset=$offset";
  }
}
