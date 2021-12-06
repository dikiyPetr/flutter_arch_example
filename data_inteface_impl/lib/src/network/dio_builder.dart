import 'package:dio/dio.dart';

class DioBuilder {
  DioBuilder._();

  static Dio build(String apiKey) => Dio(BaseOptions(
        baseUrl: 'https://api.nasa.gov/',
        queryParameters: {'api_key': apiKey},
      ));
}
