import 'package:flutter/material.dart';
import 'package:nasa_feed/app/page/favorites_tab.dart';

import 'feed_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Near Earth Object"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.favorite))
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FeedTab(),
            FavoritesTab(),
          ],
        ),
      ),
    );
  }
}
