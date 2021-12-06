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
      emit(MainPageStateLoaded(items));
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
      emit(MainPageStateLoaded(items));
    }
  }

  void _refresh(
    MainPageEventRefresh event,
    Emitter<MainPageState> emit,
  ) async {
    final items = await _worker.getLatest();
    event.completer?.complete();
    emit(MainPageStateLoaded(items));
  }
}
