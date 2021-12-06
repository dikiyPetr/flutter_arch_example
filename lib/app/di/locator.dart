import 'package:get_it/get_it.dart';
import 'package:nasa_feed/app/simple_state_management/main_page_state_manager.dart';

class ServiceLocator {
  static final _getIt = GetIt.instance;

  static MainPageStateManager get mainPageStateManager => _getIt.get();

  ServiceLocator._();
}
