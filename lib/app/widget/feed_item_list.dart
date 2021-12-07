import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nasa_feed/app/redux/main_page/thunk.dart';
import 'package:nasa_feed/app/redux/store.dart';
import 'package:nasa_feed/app/widget/feed_item_widget.dart';

class FeedItemList extends StatelessWidget {
  final Map<FeedItem, bool> map;
  final void Function(FeedItem item)? onTap;

  const FeedItemList({
    required this.map,
    this.onTap,
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
            final storeProvider =
                StoreProvider.of<GlobalState>(context, listen: false);

            storeProvider.dispatch(
              isFavorite
                  ? RemoveFromFavoritesThunk(item)
                  : AddToFavoriteThunk(item),
            );
          },
          child: FeedItemWidget(
            item: item,
            isFavorite: isFavorite,
          ),
        );
      },
    );
  }
}
