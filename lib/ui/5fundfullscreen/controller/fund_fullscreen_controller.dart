import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class FundFullscreenController extends GetxController {
  final String title = Get.arguments ?? 'Mothilal Growth';

  var selectedPeriod = "MAX".obs;

  var investmentSpots = <FlSpot>[].obs;
  var niftySpots = <FlSpot>[].obs;
  RxDouble investedAmount = 1000.0.obs;
  RxDouble currentValue = 1280.0.obs;
  RxDouble totalGain = 220.16.obs;
  RxList<double> investmentGrowth = [-10.75, -12.97].obs;

  RxList<String> label = ["2022", "2023", "2024", "2025"].obs; // Sample values

  final List<double> barValues = [1.19, 3.63, 4.55];

  @override
  void onInit() {
    updateChartData("MAX");
    super.onInit();
  }

  void updateInvestment(double amount) {
    investedAmount.value = amount;
    currentValue.value = amount * 1.28;
    totalGain.value = currentValue.value - investedAmount.value;
  }

  void updateChartData(String period) {
    selectedPeriod.value = period;

    int dataPoints;
    switch (period) {
      case "1M":
        dataPoints = 3;
        break;
      case "3M":
        dataPoints = 6;
        break;
      case "6M":
        dataPoints = 9;
        break;
      case "1Y":
        dataPoints = 12;
        break;
      case "MAX":
        dataPoints = 15;
        break;
      default:
        dataPoints = 18;
    }

    label.value = List.generate(dataPoints, (index) => (index + 1).toString());

    investmentSpots.value = generateChartData(dataPoints, startValue: 2.0);
    niftySpots.value = generateChartData(dataPoints, startValue: 1.5);
  }

  List<FlSpot> generateChartData(int count, {double startValue = 1.0}) {
    List<FlSpot> spots = [];
    Random random = Random();
    double value = startValue;

    for (int i = 0; i < count; i++) {
      value += (random.nextDouble() * 20) - 5.5;
      if (value < 0) value = 0.5;
      spots.add(FlSpot(i.toDouble(), value));
    }
    return spots;
  }
}
