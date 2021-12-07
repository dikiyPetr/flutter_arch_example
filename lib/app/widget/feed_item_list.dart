import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_feed/app/di/locator.dart';
import 'package:nasa_feed/app/widget/feed_item_widget.dart';

class FeedItemList extends StatefulWidget {
  final Map<FeedItem, bool> map;
  final void Function(FeedItem item)? onTap;

  const FeedItemList({
    required this.map,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<FeedItemList> createState() => _FeedItemListState();
}

class _FeedItemListState extends State<FeedItemList> {
  final _feedWorker = Locator.feedWorker;

  @override
  Widget build(BuildContext context) {
    final items = widget.map.keys.toList();
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return InkWell(
            onTap: () => _addToFavorite(item),
            child: FeedItemWidget(
                item: item, isFavorite: widget.map[item] == true),
          );
        });
  }

  void _addToFavorite(FeedItem item) {
    final isFavorite = widget.map[item];
    if (isFavorite == null) {
      return;
    }
    if (isFavorite) {
      _feedWorker.removeFromFavorites(item);
      widget.map[item] = false;
    } else {
      _feedWorker.addToFavorites(item);
      widget.map[item] = true;
    }
    setState(() {});
  }
}
