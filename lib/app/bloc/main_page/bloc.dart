import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:nasa_feed/app/bloc/main_page/state.dart';

import 'event.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final FeedWorker _worker;

  MainPageBloc(this._worker) : super(MainPageStateProgress()) {
    on<MainPageEventAddToFavorites>(_addToFavorites);
    on<MainPageEventRemoveFromFavorites>(_removeFromFavorites);
    on<MainPageEventRefresh>(_refresh);

    add(MainPageEventRefresh());
  }

  void _addToFavorites(
    MainPageEventAddToFavorites event,
    Emitter<MainPageState> emit,
  ) async {
    final item = event.item;
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

  void _removeFromFavorites(
    MainPageEventRemoveFromFavorites event,
    Emitter<MainPageState> emit,
  ) async {
    final item = event.item;
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

  void _refresh(
    MainPageEventRefresh event,
    Emitter<MainPageState> emit,
  ) async {
    final items = await _worker.getLatest();
    final favoriteItems =
        Map.fromEntries(items.entries.where((element) => element.value));
    event.completer?.complete();
    emit(MainPageStateLoaded(items, favoriteItems));
  }
}
