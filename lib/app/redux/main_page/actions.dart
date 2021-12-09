import 'dart:async';

import 'package:data/data.dart';

class SetFeedItemsAction {
  final Map<FeedItem, bool> items;
  final Map<FeedItem, bool> favoriteItems;

  SetFeedItemsAction({
    required this.items,
    required this.favoriteItems,
  });
}

class SetIsProgressAction {
  final bool isProgress;

  SetIsProgressAction(this.isProgress);
}

class SetHasErrorAction {
  final bool hasError;

  SetHasErrorAction(this.hasError);
}

abstract class MainPageAction {}

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
