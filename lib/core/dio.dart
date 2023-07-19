import 'package:dio/dio.dart';

class DioSingleton {
  static final DioSingleton _instance = DioSingleton._internal();

  factory DioSingleton() => _instance;

  DioSingleton._internal() {
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
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
  }

  final _client = Dio(BaseOptions(
    baseUrl: "http://localhost:3000",
  ));

  Dio get client => _client;

  void addInterceptors(Interceptor interceptor) {
    _client.interceptors.add(interceptor);
  }
}
