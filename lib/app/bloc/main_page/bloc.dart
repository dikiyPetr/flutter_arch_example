import 'package:bloc/bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:nasa_feed/app/bloc/main_page/state.dart';

class MainPageBloc extends Cubit<MainPageState> {
  final FeedWorker _worker;

  MainPageBloc(this._worker) : super(MainPageStateProgress()) {
    refresh();
  }

  void addToFavorites(FeedItem item) async {
    await _worker.addToFavorites(item);
    final currentState = state;
    if (currentState is MainPageStateLoaded) {
      final items = Map.of(currentState.items);
      items[item] = true;
      final favoriteItems = Map.of(currentState.favoriteItems);
      favoriteItems[item] = true;

      emit(MainPageStateLoaded(items, favoriteItems));
    }
  }

  void removeFromFavorites(FeedItem item) async {
    _worker.removeFromFavorites(item);
    final currentState = state;
    if (currentState is MainPageStateLoaded) {
      final items = Map.of(currentState.items);
      items[item] = false;
      final favoriteItems = Map.of(currentState.favoriteItems);
      favoriteItems[item] = true;
      emit(MainPageStateLoaded(items, favoriteItems));
    }
  }

  Future<void> refresh() async {
    final items = await _worker.getLatest();
    final favoriteItems =
        Map.fromEntries(items.entries.where((element) => element.value));
    emit(MainPageStateLoaded(items, favoriteItems));
  }
}
