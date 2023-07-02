import 'package:dio/dio.dart';

class Webservice {
  Dio dio;

  Webservice() : dio = Dio(BaseOptions(baseUrl: "http://localhost:3000"));

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
