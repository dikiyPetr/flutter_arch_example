import 'package:flutter/material.dart';
import 'package:nasa_feed/app/simple_state_management/main_page_state_manager.dart';
import 'package:nasa_feed/app/widget/feed_item_list.dart';
import 'package:provider/provider.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainPageState = context.watch<MainPageStateManager>().value;
    if (mainPageState.hasError) {
      return const Center(child: Icon(Icons.error));
    } else if (mainPageState.isProgress) {
      return const Center(child: CircularProgressIndicator());
    } else {
      final items = mainPageState.items;
      final map =
          Map.fromEntries(items.entries.where((element) => element.value));

      return FeedItemList(map: map);
    }
  }
}
