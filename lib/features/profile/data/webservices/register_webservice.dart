import 'package:play_tennis_hk/core/webservice.dart';
import 'package:play_tennis_hk/features/profile/data/webservices/login_response.dart';

class RegisterWebservice extends Webservice {
  Future<LoginResponse> performRequest(Object data) async {
    final response = await dio.post("/profile/register", data: data);

    try {
      final data = LoginResponse.fromJson(response.data);
      return data;
    } catch (err) {
      rethrow;
    }
  }
}
