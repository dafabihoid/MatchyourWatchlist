import '../class/Watchlist.dart';

class Watchlists {
  static final Watchlists _watchlists = Watchlists._internal();

  Watchlist mainList = Watchlist();
  Watchlist alreadyWatchedList = Watchlist();
  List<Watchlist> customWatchlists = <Watchlist>{}.toList(growable: true);

  factory Watchlists(){
    return _watchlists;
  }

  Watchlists._internal();

}