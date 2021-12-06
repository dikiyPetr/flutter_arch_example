import 'package:data/data.dart';
import 'package:flutter/material.dart';

class FeedItemWidget extends StatelessWidget {
  final FeedItem item;
  final bool isFavorite;

  const FeedItemWidget(
      {required this.item, required this.isFavorite, Key? key, z})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(item.name),
        leading: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      );
}
