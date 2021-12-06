import 'package:data/data.dart';
import 'package:hive/hive.dart';

part 'feed_hive_model.g.dart';

@HiveType(typeId: 0)
class FeedHiveModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  FeedHiveModel(this.id, this.name);

  FeedHiveModel.fromFeed(FeedItem feedItem)
      : id = feedItem.id,
        name = feedItem.name;

  FeedItem toFeedItem() => FeedItem(id: id, name: name);
}
