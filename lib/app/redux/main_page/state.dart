import 'package:data/data.dart';

class MainPageState {
  static const initState = MainPageState(
    items: {},
    isProgress: true,
    hasError: false,
    favoriteItems: {},
  );
  final bool hasError;
  final bool isProgress;
  final Map<FeedItem, bool> items;
  final Map<FeedItem, bool> favoriteItems;

  const MainPageState({
    required this.hasError,
    required this.isProgress,
    required this.items,
    required this.favoriteItems,
  });

  MainPageState copyWith({
    bool? hasError,
    bool? isProgress,
    Map<FeedItem, bool>? items,
    Map<FeedItem, bool>? favoriteItems,
  }) =>
      MainPageState(
        hasError: hasError ?? this.hasError,
        isProgress: isProgress ?? this.isProgress,
        items: items ?? this.items,
        favoriteItems: favoriteItems ?? this.favoriteItems,
      );
}
