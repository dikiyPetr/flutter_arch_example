import 'package:data/data.dart';
import 'package:data_inteface_impl/data_inteface_impl.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:nasa_feed/app/di/secure_params.dart';
import 'package:nasa_feed/app/di/worker_provider.dart';
import 'package:nasa_feed/app/redux/store.dart';
import 'package:redux/redux.dart';

@module
abstract class AppModule {
  @singleton
  @preResolve
  Future<SecureParams> secureParams() => SecureParams.init();

  @singleton
  @preResolve
  Future<HiveBuilder> hiveBuilder() => HiveBuilder.build();

  @lazySingleton
  Dio dio(SecureParams secureParams) => DioBuilder.build(secureParams.apiKey);

  @lazySingleton
  FeedApi feedApi(Dio dio) => FeedApiImpl(dio);

  @lazySingleton
  FeedDao feedDao(HiveBuilder hiveBuilder) => FeedDaoImpl(hiveBuilder.feedBox);

  @lazySingleton
  FeedWorker feedWorker(FeedApi feedApi, FeedDao feedDao) =>
      FeedWorker(feedDao, feedApi);

  @lazySingleton
  WorkerProvider workerProvider(FeedWorker feedWorker) =>
      WorkerProvider(feedWorker);

  @lazySingleton
  Store<GlobalState> store(WorkerProvider workerProvider) =>
      MyStoreBuilder.build(workerProvider);
}
