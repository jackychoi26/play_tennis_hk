import 'package:dio/dio.dart';
import 'package:play_tennis_hk/features/profile/data/token_repository_impl.dart';
import 'package:play_tennis_hk/features/profile/domain/providers/token_provider.dart';

// final dioProvider = Provider<DioSingleton>((ref) {
//   final token = ref.watch(tokenProvider.notifier);
//   return DioSingleton._internal(tokenNotifier: token);
// });

class DioSingleton {
  static final DioSingleton _instance = DioSingleton._internal(
    tokenNotifier: TokenNotifier(TokenRepositoryImpl()),
  );

  factory DioSingleton() => _instance;
  DioSingleton._internal({
    required TokenNotifier tokenNotifier,
  }) {
    _client.interceptors.add(LogInterceptor(responseBody: true));

    _client.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // final token = await tokenRepository.getAccessToken();
      // _client.options.headers["Authorization"] = token;

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
    }, onError: (DioException e, handler) async {
      if (e.response?.statusCode == 401) {
        // If the request fails with a 401 status code, log the user out
        tokenNotifier.removeAccessToken();
      }
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
  }

  final _client = Dio(BaseOptions(
    baseUrl: "http://localhost:3000",
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 60 * 1000),
    receiveTimeout: const Duration(seconds: 60 * 1000),
  ));

  Dio get client => _client;
}
