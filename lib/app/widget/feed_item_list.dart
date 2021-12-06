import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_feed/app/simple_state_management/main_page_state_manager.dart';
import 'package:nasa_feed/app/widget/feed_item_widget.dart';
import 'package:provider/provider.dart';

class FeedItemList extends StatelessWidget {
  final Map<FeedItem, bool> map;

  const FeedItemList({
    required this.map,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = map.keys.toList();
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        final isFavorite = map[item] == true;
        return InkWell(
          onTap: () {
            final stateManager = context.read<MainPageStateManager>();
            if (isFavorite) {
              stateManager.removeFromFavorite(item);
            } else {
              stateManager.addToFavorite(item);
            }
          },
          child: FeedItemWidget(item: item, isFavorite: isFavorite),
        );
      },
    );
  }
}
