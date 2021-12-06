import 'dart:async';

import 'package:data/data.dart';

abstract class MainPageEvent {}

class MainPageEventAddToFavorites extends MainPageEvent {
  final FeedItem item;

  MainPageEventAddToFavorites(this.item);
}

class MainPageEventRemoveFromFavorites extends MainPageEvent {
  final FeedItem item;

  MainPageEventRemoveFromFavorites(this.item);
}

class MainPageEventRefresh extends MainPageEvent {
  final Completer<void>? completer;

  MainPageEventRefresh([this.completer]);
}
