import 'package:dio/dio.dart';
import 'dio_base.dart';

class DioService {
  DioService._();

  static final instance = DioService._();
  static Dio _dio = DioBase.getDio();

  Dio get() => _dio;

  void updateDioWithToken(String token) {
    _dio = DioBase.addToken(token);
  }
}
