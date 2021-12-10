import 'dart:async';

import 'package:data/data.dart';

abstract class MainPageAction {}

class SetFeedItemsAction extends MainPageAction {
  final Map<FeedItem, bool> items;
  final Map<FeedItem, bool> favoriteItems;

  SetFeedItemsAction({
    required this.items,
    required this.favoriteItems,
  });
}

class SetIsProgressAction extends MainPageAction {
  final bool isProgress;

  SetIsProgressAction(this.isProgress);
}

class SetHasErrorAction extends MainPageAction {
  final bool hasError;

  SetHasErrorAction(this.hasError);
}

class RefreshAction extends MainPageAction {
  final Completer<void>? completer;

  RefreshAction([this.completer]);
}

class AddToFavoriteAction extends MainPageAction {
  final FeedItem item;

  AddToFavoriteAction(this.item);
}

class RemoveFromFavoriteAction extends MainPageAction {
  final FeedItem item;

  RemoveFromFavoriteAction(this.item);
}
