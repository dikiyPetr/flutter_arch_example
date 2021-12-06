import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const NasaFeedApp()),
    blocObserver: _MyBlocObserver(),
  );
}

class _MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }
}
