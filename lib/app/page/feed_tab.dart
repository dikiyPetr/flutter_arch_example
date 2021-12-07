import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:nasa_feed/app/di/locator.dart';
import 'package:nasa_feed/app/widget/feed_item_list.dart';

class FeedTab extends StatefulWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  final _feedWorker = Locator.feedWorker;
  late Future<Map<FeedItem, bool>> _feedItemsFuture = _feedWorker.getLatest();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final feedItemsFuture = _feedWorker.getLatest();
        await feedItemsFuture;
        _feedItemsFuture = feedItemsFuture;
        setState(() {});
      },
      child: FutureBuilder<Map<FeedItem, bool>>(
        future: _feedItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final map = snapshot.requireData;
            return FeedItemList(map: map);
          } else if (snapshot.hasError) {
            return const Center(
              child: Icon(Icons.error),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
