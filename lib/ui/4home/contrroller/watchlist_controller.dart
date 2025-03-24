import 'package:get/get.dart';

import '../../../app/models/watchlist_item.dart';

class WatchlistController extends GetxController {
  var watchlists = ["all"].obs;
  var selectedTab = 0.obs;
  var items = <String, List<WatchlistItem>>{}.obs;
  var watchlist = <WatchlistItem>[
    WatchlistItem(
      title: "HDFC Balanced Advantage...",
      category: "Others | Funds of Funds",
      nav: "₹13.57",
      oneDay: "1.39%",
      oneYear: "101.8%",
      threeYear: "20.2%",
      fiveYear: "25.50%",
      expenseRatio: "25.50%",
    ),
    WatchlistItem(
      title: "HDFC Mid-Cap Opportunit...",
      category: "Others | Funds of Funds",
      nav: "₹13.57",
      oneDay: "1.39%",
      oneYear: "101.8%",
      threeYear: "20.2%",
      fiveYear: "25.50%",
      expenseRatio: "25.50%",
    ),
    WatchlistItem(
      title: "HDFC Liquid Fund",
      category: "Others | Funds of Funds",
      nav: "₹13.57",
      oneDay: "1.39%",
      oneYear: "101.8%",
      threeYear: "20.2%",
      fiveYear: "25.50%",
      expenseRatio: "25.50%",
    ),
  ].obs;

  @override
  void onInit() {
    items["all"] = watchlist;
    super.onInit();
  }

  // Add a new watchlist tab
  void addWatchlist(String name) {
    if (name.isNotEmpty && !watchlists.contains(name)) {
      watchlists.add(name);
      items[name] = []; // Initialize list for new watchlist
      update();
    }
  }

  // Add an item to the selected watchlist
  void addItemToWatchlist(WatchlistItem item) {
    final currentList = watchlists[selectedTab.value];
    items[currentList]?.add(item);
    update();
  }

  void removeItem(int index) {
    watchlist.removeAt(index);
  }
}
