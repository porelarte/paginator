import 'dart:developer';

class Paginator {
  final int pageCount;
  late final Function _fetchNextCallback;

  Paginator({
    required this.pageCount,
    required Function(int) fetchNextCallback,
  }) : _fetchNextCallback = fetchNextCallback;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  bool get hasReachedMax => pageCount - 1 == currentPage;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  Future<void> maybeFetch() async {
    if (!_isBusy && !hasReachedMax) {
      _isBusy = true;
      _currentPage++;

      log('Fetching page N=$currentPage.');

      await _fetchNextCallback(currentPage);
      _isBusy = false;
    } else {
      log('Ignoring pagination');
    }
  }
}
