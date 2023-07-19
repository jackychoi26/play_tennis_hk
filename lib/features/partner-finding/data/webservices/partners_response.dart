import 'package:play_tennis_hk/core/webservice_response.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class PartnersResponse extends WebserviceResponse {
  PartnersResponse(String message, this.userProfiles) : super(message);

  List<UserProfile> userProfiles;

  factory PartnersResponse.fromJson(Map<String, dynamic> json) {
    final list = json['userProfiles'] as List;

    List<UserProfile> userProfiles =
        list.map((userProfile) => UserProfile.fromJson(userProfile)).toList();

    return PartnersResponse(json['message'], userProfiles);
  }
}
