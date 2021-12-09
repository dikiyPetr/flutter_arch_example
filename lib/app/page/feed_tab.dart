import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_feed/app/bloc/main_page/bloc.dart';
import 'package:nasa_feed/app/bloc/main_page/state.dart';
import 'package:nasa_feed/app/widget/feed_item_list.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<MainPageBloc>(context).refresh(),
      child: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
          if (state is MainPageStateLoaded) {
            return FeedItemList(map: state.items);
          } else if (state is MainPageStateProgress) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Icon(Icons.error));
          }
        },
      ),
    );
  }
}
