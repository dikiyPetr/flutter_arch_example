import 'package:data/data.dart';
import 'package:dio/dio.dart';

import 'feed_network_model.dart';

class FeedApiImpl extends FeedApi {
  final Dio _dio;

  FeedApiImpl(this._dio);

  @override
  Future<List<FeedItem>> getLatest() async {
    final response = await _dio.get('neo/rest/v1/feed');
    final nearEarthObjects = response.data['near_earth_objects'] as Map;
    return nearEarthObjects.values
        .expand((element) => element)
        .map((e) => FeedNetworkModel.fromJson(e).toFeedItem())
        .toList();
  }
}
