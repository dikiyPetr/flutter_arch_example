import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:nasa_feed/app/bloc/main_page/state.dart';

class MainPageBloc extends Cubit<MainPageState> {
  final FeedWorker _worker;

  MainPageBloc(this._worker) : super(MainPageState.init()) {
    refresh();
  }

  void addToFavorites(FeedItem item) async {
    await _worker.addToFavorites(item);
    final currentState = state;
    final items = Map.of(currentState.items);
    items[item] = true;
    final favoriteItems = Map.of(currentState.favoriteItems);
    favoriteItems[item] = true;

    emit(state.copyWith(items: items, favoriteItems: favoriteItems));
  }

  void removeFromFavorites(FeedItem item) async {
    _worker.removeFromFavorites(item);
    final currentState = state;
    final items = Map.of(currentState.items);
    items[item] = false;
    final favoriteItems = Map.of(currentState.favoriteItems);
    favoriteItems[item] = true;

    emit(state.copyWith(items: items, favoriteItems: favoriteItems));
  }

  Future<void> refresh([bool withProgress = true]) async {
    emit(state.copyWith(isProgress: withProgress, hasError: false));
    try {
      final items = await _worker.getLatest();
      final favoriteItems =
          Map.fromEntries(items.entries.where((element) => element.value));

      emit(state.copyWith(items: items, favoriteItems: favoriteItems));
    } catch (e) {
      emit(state.copyWith(hasError: true));
    } finally {
      emit(state.copyWith(isProgress: false));
    }
  }
}
