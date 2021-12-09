import 'package:nasa_feed/app/di/worker_provider.dart';
import 'package:redux/redux.dart';

import 'main_page/actions.dart';
import 'main_page/middleware.dart';
import 'main_page/reducer.dart';
import 'main_page/state.dart';

class MyStoreBuilder {
  MyStoreBuilder._();

  static Store<GlobalState> build(WorkerProvider workerProvider) =>
      Store<GlobalState>(
        _globalReducer,
        initialState: GlobalState.initState,
        middleware: [
          TypedMiddleware<GlobalState, MainPageAction>(
              MainPageMiddleware(workerProvider)),
        ],
      );
}

GlobalState _globalReducer(GlobalState state, action) => GlobalState(
      mainPage: mainPageReducer(state.mainPage, action),
    );

class GlobalState {
  static const initState = GlobalState(mainPage: MainPageState.initState);
  final MainPageState mainPage;

  const GlobalState({
    required this.mainPage,
  });
}
