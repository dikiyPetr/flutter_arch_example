import 'package:data/data.dart';

class SetFeedItemsAction {
  final Map<FeedItem, bool> items;

  SetFeedItemsAction(this.items);
}

class SetIsProgressAction {
  final bool isProgress;

  SetIsProgressAction(this.isProgress);
}

class SetHasErrorAction {
  final bool hasError;

  SetHasErrorAction(this.hasError);
}
