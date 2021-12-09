import 'package:data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_feed/app/bloc/main_page/bloc.dart';
import 'package:nasa_feed/app/bloc/main_page/export.dart';
import 'package:nasa_feed/app/widget/feed_item_widget.dart';

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
        return InkWell(
          onTap: () => _addToFavorite(context, item),
          child: FeedItemWidget(item: item, isFavorite: map[item] == true),
        );
      },
    );
  }

  void _addToFavorite(BuildContext context, FeedItem item) {
    final isFavorite = map[item];
    if (isFavorite == null) {
      return;
    }
    final bloc = BlocProvider.of<MainPageBloc>(context);
    if (isFavorite) {
      bloc.removeFromFavorites(item);
    } else {
      bloc.addToFavorites(item);
    }
  }
}
