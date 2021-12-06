import 'package:data/src/model/feed_item.dart';

abstract class FeedDao {
  Future<void> save(FeedItem feedItem);

  Future<List<FeedItem>> getAll();

  Future<void> delete(FeedItem item);
}
