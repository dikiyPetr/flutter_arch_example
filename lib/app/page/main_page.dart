import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nasa_feed/app/page/favorites_tab.dart';
import 'package:nasa_feed/app/redux/main_page/thunk.dart';
import 'package:nasa_feed/app/redux/store.dart';

import 'feed_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    final storeProvider = StoreProvider.of<GlobalState>(context, listen: false);
    storeProvider.dispatch(RefreshThunk());
  }

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
