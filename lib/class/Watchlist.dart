import '../class/Media.dart';

class Watchlist {
  late int watchlistId;
  late String watchlistName;
  late bool isMainList;
  late bool isAlreadyWatchedList;
  List<Media> watchlistItems = <Media>{}.toList(growable: true);
}

