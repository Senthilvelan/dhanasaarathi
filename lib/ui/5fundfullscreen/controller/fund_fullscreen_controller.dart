import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FundFullscreenController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  final String title = Get.arguments ?? 'Mothilal Growth';

  var selectedPeriod = "MAX".obs;

  var investmentSpots = <FlSpot>[].obs;
  var niftySpots = <FlSpot>[].obs;
  RxDouble navAmount = 104.2.obs;
  RxDouble nav1dayAmount = 4.7.obs;

  RxDouble investedAmount = 100000.0.obs;
  RxDouble currentValue = 1280.0.obs;
  RxDouble totalGain = 220.16.obs;
  RxList<double> investmentGrowth = [-10.75, -12.97].obs;

  RxList<String> label = ["2022", "2023", "2024", "2025"].obs; // Sample values

  final List<double> barValues = [1.19, 3.63, 4.55];

  RxInt selectedToggleIndex = 0.obs;

  RxDouble pastReturnAmount = 3.60.obs;

  RxDouble height = 50.0.obs;

  @override
  void onInit() {
    updateChartData("MAX");
    textEditingController.text = "₹1L";

    focusNode.addListener(() {
      if (textEditingController == null) return;
      if (textEditingController.text == null) return;
      String txtvalue = textEditingController.text;
      txtvalue = txtvalue.trim();

      if (focusNode.hasFocus) {
        if (txtvalue.contains("₹")) {
          txtvalue.replaceAll("₹", "");
          txtvalue = txtvalue.replaceAll(RegExp(r'[^0-9.]'), '');
        }
      } else {
        if (!txtvalue.contains("₹")) {
          textEditingController.text = "₹" + txtvalue;
        }
      }
    });

    textEditingController.addListener(() {
      if (textEditingController == null) return;
      if (textEditingController.text == null) return;
      String txtvalue = textEditingController.text;
      txtvalue = txtvalue.trim();

      if (txtvalue.length == null) return;

      if (txtvalue.length <= 7) {
        try {
          double? value = double.tryParse(txtvalue);
          if (value == null || value < 1.00 || value > 10.00) {
          } else {
            updateInvestment(value * 100000);
          }
        } catch (e) {
          if (kDebugMode) print(e);
        }
      }
    });

    super.onInit();
  }

  void updateInvestment(double amount) {
    // amount = amount * 100000;
    investedAmount.value = amount;
    currentValue.value = amount * 1.28;
    totalGain.value = currentValue.value - investedAmount.value;
    textEditingController.text = "₹${convertToLakh(amount)}";

    pastReturnAmount.value = amount * 3.553;
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

  String convertToLakh(double amount) {
    if (amount >= 100000) {
      double lakhValue = amount / 100000;
      return lakhValue.toStringAsFixed(2).endsWith(".00")
          ? "${lakhValue.toStringAsFixed(0)}L"
          : "${lakhValue.toStringAsFixed(2)}L";
    } else if (amount >= 1000 && amount < 100000) {
      double value = amount / 1000;
      return value.toStringAsFixed(2).endsWith(".00")
          ? "${value.toStringAsFixed(0)}k"
          : "${value.toStringAsFixed(2)}k";
    }
    return "${amount.toStringAsFixed(2)}";
  }

  double calculateReturns(double multiplier) {
    return (investedAmount.value / 100000) * multiplier;
  }

  double calculateProfit(double multiplier) {
    return calculateReturns(multiplier) - (investedAmount.value / 100000);
  }

  void updateInvestment1(double value) {
    investedAmount.value = value;
  }

  void onTapToggles(int i) {
    selectedToggleIndex.value = i;
    // Utilities.showToast("DhanSaarathi", "Toggle under contruction");
  }
}
