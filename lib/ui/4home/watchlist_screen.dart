import 'package:dhansaarathi/app/utils_res/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'contrroller/watchlist_controller.dart';

class WatchlistScreen extends StatelessWidget {
  final WatchlistController controller = Get.put(WatchlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Watchlist", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Dynamic Tabs
          Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  child: Row(
                    children:
                        List.generate(controller.watchlists.length, (index) {
                      return InkWell(
                        onTap: () => controller.onListTap(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: controller.selectedTab.value == index
                                ? blueMarine
                                : Colors.grey[800],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            controller.watchlists[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )),
          const SizedBox(height: 20),

          // Watchlist Items
          Obx(() {
            var currentList =
                controller.watchlists[controller.selectedTab.value];
            var items = controller.items[currentList] ?? [];

            if (items.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.show_chart,
                          color: Colors.white38, size: 50),
                      const SizedBox(height: 8),
                      const Text("Looks like your watchlist is empty.",
                          style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () => showAddItemDialog(context),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text("Add Mutual Funds",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800]),
                      )
                    ],
                  ),
                ),
              );
            }

            // return Expanded(child: Obx(() => getListWatchListItems()));
            return Expanded(child: getListWatchListItems());

          }),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddWatchlistDialog(context),
        backgroundColor: blueMarine,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          "Watchlist",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  getListWatchListItems() {
    return Column(
      children: [
        // Search Box
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: TextField(
            controller: controller.searchController,
            onChanged: (value) => controller.filterWatchlist(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: Colors.grey[900],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Watchlist Items
        Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  itemCount: controller.watchlist.length,
                  itemBuilder: (context, index) {
                    final item = controller.watchlist[index];
                    return Slidable(
                      key: Key(item.title),
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => controller.removeItemromUi(index),
                            backgroundColor: Colors.red.shade800,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: "Delete",
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          controller.onFundTap(item.title);
                        },
                        child: Card(
                          color: Colors.grey[900],
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Fund Name and NAV
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      "NAV ${item.nav}",
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 4),

                                // Category and 1D Performance
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.category,
                                      style: const TextStyle(
                                          color: Colors.white54, fontSize: 11),
                                    ),
                                    Text(
                                      "1D ${item.oneDay}",
                                      style: const TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                // Performance Data
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("1Y ${item.oneYear}",
                                        style: const TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 11)),
                                    Text("3Y ${item.threeYear}",
                                        style: const TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 11)),
                                    Text("5Y ${item.fiveYear}",
                                        style: const TextStyle(
                                            color: Colors.greenAccent,
                                            fontSize: 11)),
                                    Text(
                                      "Exp. Ratio ${item.expenseRatio}",
                                      style: const TextStyle(
                                          color: Colors.white54, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ))),
      ],
    );
  }

  // Show Bottom Sheet to Add Watchlist
  void showAddWatchlistDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add Watchlist",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Enter watchlist name",
                hintStyle: TextStyle(color: Colors.white38),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blueMarine)),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.addWatchlist(nameController.text.trim());
                Get.back();
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  // Show Bottom Sheet to Add Items to Watchlist
  void showAddItemDialog(BuildContext context) {
    TextEditingController itemController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Add Item to Watchlist",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              controller: itemController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Enter stock/mutual fund name",
                hintStyle: TextStyle(color: Colors.white38),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blueMarine)),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // controller.addItemToWatchlist(itemController.text.trim());
                Get.back();
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
