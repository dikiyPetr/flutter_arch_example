import 'package:flutter/services.dart';

class SecureParams {
  final String apiKey;

  SecureParams._(this.apiKey);

  static Future<SecureParams> init() async =>
      SecureParams._(await rootBundle.loadString('assets/apiKey.txt'));
}
