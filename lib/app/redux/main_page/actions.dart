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
