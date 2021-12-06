import 'package:data_inteface_impl/src/dao/feed_hive_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBuilder {
  final Box<FeedHiveModel> feedBox;

  HiveBuilder._(this.feedBox);

  static Future<HiveBuilder> build() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FeedHiveModelAdapter());
    return HiveBuilder._(
      await Hive.openBox('feed'),
    );
  }
}
