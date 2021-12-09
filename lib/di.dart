import 'package:data_inteface_impl/data_inteface_impl.dart';
import 'package:domain/domain.dart';
import 'package:flutter/services.dart';

class Dependencies {
  final FeedWorker feedWorker;
  static late final Dependencies instance;

  Dependencies._(this.feedWorker);

  static Future<Dependencies> build() async {
    final secureParams =
        SecureParams(await rootBundle.loadString('assets/apiKey.txt'));
    final dio = DioBuilder.build(secureParams.apiKey);
    final hiveBuilder = await HiveBuilder.build();
    final feedDao = FeedDaoImpl(hiveBuilder.feedBox);
    final feedApi = FeedApiImpl(dio);
    final feedWorker = FeedWorker(feedDao, feedApi);
    return instance = Dependencies._(feedWorker);
  }
}

class SecureParams {
  final String apiKey;

  SecureParams(this.apiKey);
}
