import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/watchlist_controller.dart';

class WatchlistScreen extends StatelessWidget {
  final WatchlistController controller = Get.find<WatchlistController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Watchlist")),
      body: Column(
        children: [
          TextField(
            onChanged: controller.searchFunds,
            decoration: InputDecoration(
              labelText: "Search Funds",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          DropdownButton<String>(
            value: controller.selectedSort.value,
            items: ['NAV', 'Returns'].map((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: controller.sortFunds,
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.watchlist.length,
              itemBuilder: (context, index) {
                final fund = controller.watchlist[index];
                return ListTile(
                  title: Text(fund.name),
                  subtitle: Text("NAV: ${fund.nav}, Returns: ${fund.returns}%"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => controller.removeFund(index),
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
