import 'package:data/data.dart';

class MainPageState {
  final Map<FeedItem, bool> items;
  final bool isProgress;
  final bool hasError;

  MainPageState({
    required this.items,
    this.isProgress = false,
    this.hasError = false,
  });

  static MainPageState init() => MainPageState(items: {});
}
