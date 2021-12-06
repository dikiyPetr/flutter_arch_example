import 'package:data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MainPageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MainPageStateProgress extends MainPageState {}

class MainPageStateError extends MainPageState {}

class MainPageStateLoaded extends MainPageState {
  final Map<FeedItem, bool> items;

  MainPageStateLoaded(this.items);

  @override
  List<Object?> get props => [items];
}
