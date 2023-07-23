import 'package:play_tennis_hk/core/webservice_response.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class ProfileResponse extends WebserviceResponse {
  ProfileResponse(
    String message,
    this.userProfile,
  ) : super(message);

  UserProfile userProfile;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      json['message'],
      UserProfile.fromJson(
        json['userProfile'],
      ),
    );
  }
}
