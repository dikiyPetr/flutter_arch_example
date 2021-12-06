import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';

import 'main_page_state.dart';

class MainPageStateManager extends ValueNotifier<MainPageState> {
  final FeedWorker _worker;

  MainPageStateManager(this._worker) : super(MainPageState.init()) {
    refresh();
  }

  Future<void> refresh() async {
    value = MainPageState(items: value.items, isProgress: true);
    try {
      value = MainPageState(items: await _worker.getLatest());
    } catch (e) {
      value = MainPageState(items: value.items, hasError: false);
    }
  }

  void addToFavorite(FeedItem item) {
    final items = Map.of(value.items);
    items[item] = true;
    value = MainPageState(items: items);
    _worker.addToFavorites(item);
  }

  void removeFromFavorite(FeedItem item) {
    final items = Map.of(value.items);
    items[item] = false;
    value = MainPageState(items: items);
    _worker.removeFromFavorites(item);
  }
}
