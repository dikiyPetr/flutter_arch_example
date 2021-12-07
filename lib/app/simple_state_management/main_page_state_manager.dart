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
    value = value.copyWith(isProgress: true, hasError: false);
    try {
      final items = await _worker.getLatest();
      final favoriteItems =
          Map.fromEntries(items.entries.where((element) => element.value));
      value = value.copyWith(items: items, favoriteItems: favoriteItems);
    } catch (e) {
      value = value.copyWith(hasError: true);
    } finally {
      value = value.copyWith(isProgress: false);
    }
  }

  void addToFavorite(FeedItem item) {
    _worker.addToFavorites(item);
    final items = Map.of(value.items);
    items[item] = true;
    final favoriteItems = Map.of(value.favoriteItems);
    favoriteItems[item] = true;
    value = value.copyWith(items: items, favoriteItems: favoriteItems);
  }

  void removeFromFavorite(FeedItem item) {
    _worker.removeFromFavorites(item);
    final items = Map.of(value.items);
    items[item] = false;
    final favoriteItems = Map.of(value.favoriteItems);
    favoriteItems[item] = false;
    value = value.copyWith(items: items, favoriteItems: favoriteItems);
  }
}
