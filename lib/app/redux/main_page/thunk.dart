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
    final map = Map.of(store.state.mainPage.items);
    map[item] = true;
    store.dispatch(SetFeedItemsAction(map));
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
    store.dispatch(SetFeedItemsAction(items));
  }
}

class RefreshThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, WorkerProvider> {
  RefreshThunk();

  @override
  call(Store<GlobalState> store, WorkerProvider extraArgument) async {
    try {
      store.dispatch(SetIsProgressAction(true));
      store.dispatch(SetHasErrorAction(false));
      final feedWorker = extraArgument.feedWorker;
      final items = await feedWorker.getLatest();
      store.dispatch(SetFeedItemsAction(items));
    } catch (e) {
      store.dispatch(SetHasErrorAction(true));
    } finally {
      store.dispatch(SetIsProgressAction(false));
    }
  }
}
