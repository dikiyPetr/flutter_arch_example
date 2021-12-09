import 'package:nasa_feed/app/di/worker_provider.dart';
import 'package:nasa_feed/app/redux/store.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

class MainPageMiddleware extends MiddlewareClass<GlobalState> {
  final WorkerProvider _workerProvider;

  MainPageMiddleware(this._workerProvider);

  @override
  call(Store<GlobalState> store, action, NextDispatcher next) {
    if (action is RefreshAction) {
      _refresh(store, action);
    } else if (action is AddToFavoriteAction) {
      _addToFavorite(store, action);
    } else if (action is RemoveFromFavoriteAction) {
      _removeFromFavorite(store, action);
    }
    next(action);
  }

  void _refresh(Store<GlobalState> store, RefreshAction action) async {
    final completer = action.completer;
    try {
      if (completer == null) {
        store.dispatch(SetIsProgressAction(true));
        store.dispatch(SetHasErrorAction(false));
      }
      final feedWorker = _workerProvider.feedWorker;
      final items = await feedWorker.getLatest();
      final favoriteItems =
          Map.fromEntries(items.entries.where((element) => element.value));
      store.dispatch(SetFeedItemsAction(
        items: items,
        favoriteItems: favoriteItems,
      ));
    } catch (e) {
      store.dispatch(SetHasErrorAction(true));
    } finally {
      completer?.complete();
      store.dispatch(SetIsProgressAction(false));
    }
  }

  void _removeFromFavorite(
      Store<GlobalState> store, RemoveFromFavoriteAction action) {
    final item = action.item;
    final feedWorker = _workerProvider.feedWorker;
    feedWorker.removeFromFavorites(item);
    final items = Map.of(store.state.mainPage.items);
    items[item] = false;
    final favoriteItems = Map.of(store.state.mainPage.favoriteItems);
    favoriteItems[item] = false;
    store.dispatch(
        SetFeedItemsAction(items: items, favoriteItems: favoriteItems));
  }

  void _addToFavorite(Store<GlobalState> store, AddToFavoriteAction action) {
    final item = action.item;
    final feedWorker = _workerProvider.feedWorker;
    feedWorker.addToFavorites(item);
    final items = Map.of(store.state.mainPage.items);
    items[item] = true;
    final favoriteItems = Map.of(store.state.mainPage.favoriteItems);
    favoriteItems[item] = true;
    store.dispatch(
        SetFeedItemsAction(items: items, favoriteItems: favoriteItems));
  }
}
