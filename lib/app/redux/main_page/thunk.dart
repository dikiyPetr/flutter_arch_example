import 'dart:async';

import 'package:data/data.dart';
import 'package:nasa_feed/app/di/worker_provider.dart';
import 'package:nasa_feed/app/redux/main_page/actions.dart';
import 'package:nasa_feed/app/redux/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AddToFavoriteThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, WorkerProvider> {
  final FeedItem item;

  AddToFavoriteThunk(this.item);

  @override
  call(Store<GlobalState> store, WorkerProvider extraArgument) {
    final feedWorker = extraArgument.feedWorker;
    feedWorker.addToFavorites(item);
    final items = Map.of(store.state.mainPage.items);
    items[item] = true;
    final favoriteItems = Map.of(store.state.mainPage.favoriteItems);
    favoriteItems[item] = true;
    store.dispatch(
        SetFeedItemsAction(items: items, favoriteItems: favoriteItems));
  }
}

class RemoveFromFavoritesThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, WorkerProvider> {
  final FeedItem item;

  RemoveFromFavoritesThunk(this.item);

  @override
  call(Store<GlobalState> store, WorkerProvider extraArgument) {
    final feedWorker = extraArgument.feedWorker;
    feedWorker.removeFromFavorites(item);
    final items = Map.of(store.state.mainPage.items);
    items[item] = false;
    final favoriteItems = Map.of(store.state.mainPage.favoriteItems);
    favoriteItems[item] = false;
    store.dispatch(
        SetFeedItemsAction(items: items, favoriteItems: favoriteItems));
  }
}

class RefreshThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, WorkerProvider> {
  final Completer<void>? _completer;

  RefreshThunk([this._completer]);

  @override
  call(Store<GlobalState> store, WorkerProvider extraArgument) async {
    try {
      if (_completer == null) {
        store.dispatch(SetIsProgressAction(true));
        store.dispatch(SetHasErrorAction(false));
      }
      final feedWorker = extraArgument.feedWorker;
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
      _completer?.complete();
      store.dispatch(SetIsProgressAction(false));
    }
  }
}
