import 'package:data/data.dart';
import 'package:data_inteface_impl/data_inteface_impl.dart';
import 'package:domain/domain.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class Locator {
  static final _getIt = GetIt.instance;

  static FeedWorker get feedWorker => _getIt.get();

  Locator._();
}
