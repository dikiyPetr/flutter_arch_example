import 'package:data/data.dart';

class FeedWorker {
  final FeedDao _feedDao;
  final FeedApi _feedApi;

  FeedWorker(this._feedDao, this._feedApi);

  Future<void> addToFavorites(FeedItem item) => _feedDao.save(item);

  void removeFromFavorites(FeedItem item) => _feedDao.delete(item);

  Future<List<FeedItem>> getFavorites() => _feedDao.getAll();

  Future<Map<FeedItem, bool>> getLatest() async {
    final items = await _feedApi.getLatest();
    final favorites = await _feedDao.getAll();
    final favoriteIds = favorites.map((e) => e.id).toSet();
    return Map.fromEntries(
        items.map((e) => MapEntry(e, favoriteIds.contains(e.id))));
  }
}
