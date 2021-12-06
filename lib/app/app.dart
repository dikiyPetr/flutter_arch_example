import 'package:flutter/material.dart';
import 'package:nasa_feed/app/page/main_page.dart';

import '../di.dart';

class NasaFeedApp extends StatefulWidget {
  const NasaFeedApp({Key? key}) : super(key: key);

  @override
  State<NasaFeedApp> createState() => _NasaFeedAppState();
}

class _NasaFeedAppState extends State<NasaFeedApp> {
  late final _buildFuture = Locator.build();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _buildFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const MaterialApp(home: MainPage());
        } else {
          return const Material();
        }
      },
    );
  }
}
