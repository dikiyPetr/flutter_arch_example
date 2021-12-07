import 'package:get_it/get_it.dart';
import 'package:nasa_feed/app/redux/store.dart';
import 'package:redux/redux.dart';

class Locator {
  static final _getIt = GetIt.instance;

  static Store<GlobalState> get store => _getIt.get();

  Locator._();
}
