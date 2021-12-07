import 'package:nasa_feed/app/di/locator.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'main_page/reducer.dart';
import 'main_page/state.dart';

late final globalStore = Store<GlobalState>(
  _globalReducer,
  initialState: GlobalState.initState,
  middleware: [ExtraArgumentThunkMiddleware(Locator.workerProvider)],
);

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
