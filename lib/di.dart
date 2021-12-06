import 'package:data/data.dart';
import 'package:data_inteface_impl/data_inteface_impl.dart';
import 'package:domain/domain.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class Locator {
  static final _getIt = GetIt.instance;

  static FeedWorker get feedWorker => _getIt.get();

  Locator._();

  static Future<void> build() {
    _getIt.registerSingletonAsync(() async =>
        SecureParams(await rootBundle.loadString('assets/apiKey.txt')));
    _getIt.registerSingletonAsync(() => HiveBuilder.build());

    _getIt.registerLazySingleton(
        () => DioBuilder.build(_getIt.get<SecureParams>().apiKey));
    _getIt.registerLazySingleton<FeedApi>(() => FeedApiImpl(_getIt.get()));

    _getIt.registerLazySingleton<FeedDao>(
        () => FeedDaoImpl(_getIt.get<HiveBuilder>().feedBox));
    _getIt.registerLazySingleton(() => FeedWorker(
          _getIt.get(),
          _getIt.get(),
        ));
    return _getIt.allReady();
  }
}

class SecureParams {
  final String apiKey;

  SecureParams(this.apiKey);
}
