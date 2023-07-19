import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/profile/data/webservices/login_response.dart';

class LoginWebservice extends Webservice {
  Future<LoginResponse> performRequest(Object data) async {
    final response = await dio.post("/profile/login", data: data);

    try {
      final data = LoginResponse.fromJson(response.data);
      return data;
    } catch (err) {
      rethrow;
    }
  }
}
