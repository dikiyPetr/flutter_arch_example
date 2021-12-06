import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_network_model.g.dart';

@JsonSerializable()
class FeedNetworkModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;

  FeedNetworkModel({required this.id, required this.name});

  factory FeedNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$FeedNetworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedNetworkModelToJson(this);

  FeedItem toFeedItem() => FeedItem(id: id, name: name);
}
