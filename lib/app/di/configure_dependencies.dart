import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'configure_dependencies.config.dart';

final _getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => $initGetIt(_getIt);
