import 'package:flutter/material.dart';
import 'package:nasa_feed/app/simple_state_management/main_page_state.dart';
import 'package:nasa_feed/app/simple_state_management/main_page_state_manager.dart';
import 'package:nasa_feed/app/widget/feed_item_list.dart';
import 'package:provider/provider.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainPageState = context.watch<MainPageState>();
    if (mainPageState.hasError) {
      return const Center(child: Icon(Icons.error));
    } else if (mainPageState.isProgress) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return RefreshIndicator(
        onRefresh: () =>
            context.read<MainPageStateManager>().refresh(withProgress: false),
        child: FeedItemList(map: mainPageState.items),
      );
    }
  }
}
