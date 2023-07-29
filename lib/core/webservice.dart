import 'package:dio/dio.dart';
import 'package:play_tennis_hk/core/dio.dart';
import 'package:play_tennis_hk/features/profile/data/token_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/token_repository.dart';

class Webservice {
  Dio dio;

  Webservice() : dio = DioSingleton().client;

  TokenRepository tokenRepository = TokenRepositoryImpl();

  Future<Response> getRequest(String endPoint) async {
    Response response;

    final token = await tokenRepository.getAccessToken();

    try {
      response = await dio.get(
        endPoint,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": token,
          },
        ),
      );
    } on DioException {
      rethrow;
    }

    return response;
  }

  Future<Response> postRequest(String endPoint, Object data) async {
    Response response;

    final token = await tokenRepository.getAccessToken();

    try {
      response = await dio.post(
        endPoint,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": token,
          },
        ),
      );
    } on DioException {
      rethrow;
    }

    return response;
  }

  Future<Response> patchRequest(String endPoint, Object data) async {
    Response response;

    final token = await tokenRepository.getAccessToken();

    try {
      response = await dio.patch(
        endPoint,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": token,
          },
        ),
      );
    } on DioException {
      rethrow;
    }

    return response;
  }

  Future<Response> deleteRequest(String endPoint, Object? data) async {
    Response response;

    final token = await tokenRepository.getAccessToken();

    try {
      response = await dio.delete(
        endPoint,
        data: data ?? {},
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": token,
          },
        ),
      );
    } on DioException {
      rethrow;
    }

    return response;
  }
}
