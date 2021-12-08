import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nasa_feed/app/redux/main_page/state.dart';
import 'package:nasa_feed/app/redux/main_page/thunk.dart';
import 'package:nasa_feed/app/redux/store.dart';
import 'package:nasa_feed/app/widget/feed_item_list.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, MainPageState>(
      distinct: true,
      converter: (store) => store.state.mainPage,
      builder: (context, state) {
        if (state.hasError) {
          return const Center(child: Icon(Icons.error));
        } else if (state.isProgress) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
              onRefresh: () async {
                final storeProvider =
                    StoreProvider.of<GlobalState>(context, listen: false);
                final completer = Completer();
                storeProvider.dispatch(RefreshThunk(completer));
                return completer.future;
              },
              child: FeedItemList(map: state.items));
        }
      },
    );
  }
}
