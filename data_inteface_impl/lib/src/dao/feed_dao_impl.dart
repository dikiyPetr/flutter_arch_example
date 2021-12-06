import 'package:data/data.dart';
import 'package:hive/hive.dart';

import 'feed_hive_model.dart';

class FeedDaoImpl extends FeedDao {
  final Box<FeedHiveModel> _box;

  FeedDaoImpl(this._box);

  @override
  Future<List<FeedItem>> getAll() async =>
      _box.values.map((e) => e.toFeedItem()).toList();

  @override
  Future<void> save(FeedItem feedItem) async =>
      _box.put(feedItem.id, FeedHiveModel.fromFeed(feedItem));

  @override
  Future<void> delete(FeedItem item) => _box.delete(item.id);

}
