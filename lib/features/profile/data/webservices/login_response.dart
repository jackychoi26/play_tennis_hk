import 'package:play_tennis_hk/core/webservice_response.dart';
import 'package:play_tennis_hk/features/profile/domain/entities/user_profile.dart';

class LoginResponse extends WebserviceResponse {
  LoginResponse(
    String message,
    this.accessToken,
    this.userProfile,
  ) : super(message);

  String accessToken;
  UserProfile userProfile;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      json['message'],
      json['accessToken'],
      UserProfile.fromJson(
        json['userProfile'],
      ),
    );
  }
}
