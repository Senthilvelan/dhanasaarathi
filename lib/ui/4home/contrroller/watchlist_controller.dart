import 'package:dhansaarathi/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/models/watchlist_item.dart';

class WatchlistController extends GetxController {
  var filteredWatchlist = <WatchlistItem>[].obs;
  TextEditingController searchController = TextEditingController();
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

  void onListTap(int index) {
    selectedTab.value = index;
  }

  void onFundTap(String title) {
    Future.delayed(const Duration(milliseconds: 300), () {
      Get.toNamed(AppRoutes.screenFullFund,arguments:title);
    });
  }

  @override
  void onInit() {
    items["all"] = watchlist;
    filteredWatchlist.assignAll(watchlist);

    super.onInit();
  }

  void filterWatchlist(String query) {
    if (query.isEmpty) {
      filteredWatchlist.assignAll(watchlist);
    } else {
      filteredWatchlist.assignAll(
        watchlist
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void removeItem(int index) {
    watchlist.removeAt(index);
    filterWatchlist(searchController.text);
  }

  void removeItemromUi(int index) {
    watchlist.removeAt(index);
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


}
