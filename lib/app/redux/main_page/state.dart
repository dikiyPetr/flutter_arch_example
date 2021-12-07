import 'package:data/data.dart';

class MainPageState {
  static const initState =
      MainPageState(items: {}, isProgress: true, hasError: false);
  final bool hasError;
  final bool isProgress;
  final Map<FeedItem, bool> items;

  const MainPageState({
    required this.hasError,
    required this.isProgress,
    required this.items,
  });

  MainPageState copyWith({
    bool? hasError,
    bool? isProgress,
    Map<FeedItem, bool>? items,
  }) =>
      MainPageState(
        hasError: hasError ?? this.hasError,
        isProgress: isProgress ?? this.isProgress,
        items: items ?? this.items,
      );
}
