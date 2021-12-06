import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:nasa_feed/app/di/locator.dart';
import 'package:nasa_feed/app/widget/feed_item_list.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  final _feedWorker = Locator.feedWorker;
  late final _feedItemsFuture = _feedWorker.getFavorites();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FeedItem>>(
      future: _feedItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.requireData;
          final map = Map.fromEntries(items.map((e) => MapEntry(e, true)));
          return FeedItemList(map: map);
        } else if (snapshot.hasError) {
          return const Center(
            child: Icon(Icons.error),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
