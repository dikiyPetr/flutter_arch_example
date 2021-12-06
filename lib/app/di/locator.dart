import 'package:get_it/get_it.dart';
import 'package:nasa_feed/app/bloc/main_page/bloc.dart';

class Locator {
  static final _getIt = GetIt.instance;

  static MainPageBloc get mainPageBloc => _getIt.get();

  Locator._();
}
