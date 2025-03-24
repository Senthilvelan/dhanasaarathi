import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/mutual_fund.dart';

class WatchlistController extends GetxController {
  var watchlist = <MutualFund>[].obs;
  var searchQuery = ''.obs;
  var selectedSort = 'NAV'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadWatchlist();
  }

  void _loadWatchlist() async {
    var box = await Hive.openBox<MutualFund>('watchlist');
    watchlist.assignAll(box.values.toList());
  }

  void addFund(MutualFund fund) {
    watchlist.add(fund);
    Hive.box<MutualFund>('watchlist').add(fund);
  }

  void removeFund(int index) {
    Hive.box<MutualFund>('watchlist').deleteAt(index);
    watchlist.removeAt(index);
  }

  void searchFunds(String query) {
    searchQuery.value = query;
  }

  void sortFunds(String criteria) {
    selectedSort.value = criteria;
    if (criteria == 'NAV') {
      watchlist.sort((a, b) => b.nav.compareTo(a.nav));
    } else if (criteria == 'Returns') {
      watchlist.sort((a, b) => b.returns.compareTo(a.returns));
    }
  }
}
