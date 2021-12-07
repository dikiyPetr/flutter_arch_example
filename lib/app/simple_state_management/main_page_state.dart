import 'package:data/data.dart';

class MainPageState {
  final Map<FeedItem, bool> items;
  final Map<FeedItem, bool> favoriteItems;
  final bool isProgress;
  final bool hasError;

  MainPageState({
    this.favoriteItems = const {},
    this.items = const {},
    this.isProgress = false,
    this.hasError = false,
  });

  MainPageState copyWith({
    Map<FeedItem, bool>? items,
    Map<FeedItem, bool>? favoriteItems,
    bool? isProgress,
    bool? hasError,
  }) =>
      MainPageState(
        items: items ?? this.items,
        favoriteItems: favoriteItems ?? this.favoriteItems,
        isProgress: isProgress ?? this.isProgress,
        hasError: hasError ?? this.hasError,
      );

  static MainPageState init() => MainPageState(items: {});
}
