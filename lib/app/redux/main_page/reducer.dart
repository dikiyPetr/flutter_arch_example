import 'package:nasa_feed/app/redux/main_page/state.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

final mainPageReducer = combineReducers<MainPageState>([
  TypedReducer<MainPageState, SetFeedItemsAction>(_setFeedItemsAction),
  TypedReducer<MainPageState, SetIsProgressAction>(_setIsProgressAction),
  TypedReducer<MainPageState, SetHasErrorAction>(_setHasErrorAction),
]);

MainPageState _setFeedItemsAction(
        MainPageState state, SetFeedItemsAction action) =>
    state.copyWith(items: action.items);

MainPageState _setIsProgressAction(
        MainPageState state, SetIsProgressAction action) =>
    state.copyWith(isProgress: action.isProgress);

MainPageState _setHasErrorAction(
        MainPageState state, SetHasErrorAction action) =>
    state.copyWith(hasError: action.hasError);
