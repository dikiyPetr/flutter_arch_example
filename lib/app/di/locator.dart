import 'package:get_it/get_it.dart';
import 'package:nasa_feed/app/di/worker_provider.dart';

class Locator {
  static final _getIt = GetIt.instance;

  static WorkerProvider get workerProvider => _getIt.get();

  Locator._();
}
