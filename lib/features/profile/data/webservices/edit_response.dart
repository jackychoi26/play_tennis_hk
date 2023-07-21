import 'package:play_tennis_hk/core/webservice_response.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class EditResponse extends WebserviceResponse {
  EditResponse(
    String message,
    this.userProfile,
  ) : super(message);

  UserProfile userProfile;

  factory EditResponse.fromJson(Map<String, dynamic> json) {
    return EditResponse(
      json['message'],
      UserProfile.fromJson(
        json['userProfile'],
      ),
    );
  }
}
