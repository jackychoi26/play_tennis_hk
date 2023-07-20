import 'package:dio/dio.dart';
import 'package:play_tennis_hk/features/profile/data/token_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/repositories/token_repository.dart';

class DioSingleton {
  static final DioSingleton _instance = DioSingleton._internal(
    tokenRepository: TokenRepositoryImpl(),
  );

  factory DioSingleton() => _instance;
  DioSingleton._internal({
    required TokenRepository tokenRepository,
  }) {

    _client.interceptors.add(LogInterceptor(responseBody: true));

    _client.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (DioException e, handler) {
      if (e.response?.statusCode == 401) {
        // If the request fails with a 401 status code, log the user out
        tokenRepository.removeAccessToken();
      }
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
  }

  final _client = Dio(BaseOptions(
    baseUrl: "http://localhost:3000",
  ));

  Dio get client => _client;
}
