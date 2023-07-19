import 'package:dio/dio.dart';
import 'package:play_tennis_hk/core/dio.dart';

class Webservice {
  Dio dio;

  Webservice() : dio = DioSingleton().client;

  Future<Response> getRequest(String endPoint) async {
    Response response;

    try {
      response = await dio.get(endPoint);
    } on DioException catch (e) {
      throw Exception(e.message);
    }

    return response;
  }
}




