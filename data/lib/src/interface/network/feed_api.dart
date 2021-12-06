import 'package:data/src/model/feed_item.dart';

abstract class FeedApi {
  Future<List<FeedItem>> getLatest();
}
