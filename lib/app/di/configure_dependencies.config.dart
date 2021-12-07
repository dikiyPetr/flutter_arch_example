// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:data/data.dart' as _i6;
import 'package:data_inteface_impl/data_inteface_impl.dart' as _i3;
import 'package:dio/dio.dart' as _i5;
import 'package:domain/domain.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app_module.dart' as _i9;
import 'secure_params.dart' as _i4;
import 'worker_provider.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  await gh.singletonAsync<_i3.HiveBuilder>(() => appModule.hiveBuilder(),
      preResolve: true);
  await gh.singletonAsync<_i4.SecureParams>(() => appModule.secureParams(),
      preResolve: true);
  gh.lazySingleton<_i5.Dio>(() => appModule.dio(get<_i4.SecureParams>()));
  gh.lazySingleton<_i6.FeedApi>(() => appModule.feedApi(get<_i5.Dio>()));
  gh.lazySingleton<_i6.FeedDao>(
      () => appModule.feedDao(get<_i3.HiveBuilder>()));
  gh.lazySingleton<_i7.FeedWorker>(
      () => appModule.feedWorker(get<_i6.FeedApi>(), get<_i6.FeedDao>()));
  gh.lazySingleton<_i8.WorkerProvider>(
      () => appModule.workerProvider(get<_i7.FeedWorker>()));
  return get;
}

class _$AppModule extends _i9.AppModule {}
