import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nasa_feed/app/page/main_page.dart';
import 'package:nasa_feed/app/redux/store.dart';

import 'di/configure_dependencies.dart';

class NasaFeedApp extends StatefulWidget {
  const NasaFeedApp({Key? key}) : super(key: key);

  @override
  State<NasaFeedApp> createState() => _NasaFeedAppState();
}

class _NasaFeedAppState extends State<NasaFeedApp> {
  late final _buildFuture = configureDependencies();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _buildFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StoreProvider(
            store: globalStore,
            child: const MaterialApp(home: MainPage()),
          );
        } else {
          return const Material();
        }
      },
    );
  }
}
