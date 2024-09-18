import 'package:dio/dio.dart';
import 'package:play_tennis_hk/core/configurator.dart';

class DioSingleton {
  static DioSingleton? _instance;
  late final Dio _dio;
  final Configurator _configurator;

  DioSingleton._internal(this._configurator) {
    _dio = Dio(BaseOptions(
      baseUrl: _configurator.getTennisMatchServiceUrl(),
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));
  }

  static DioSingleton getInstance() {
    _instance ??= DioSingleton._internal(Configurator.instance);
    return _instance!;
  }

  Dio get dio => _dio;
}
