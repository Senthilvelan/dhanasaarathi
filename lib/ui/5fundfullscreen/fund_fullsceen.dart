import 'package:dhansaarathi/app/utils/utilities.dart';
import 'package:dhansaarathi/app/utils/widgets/background_main.dart';
import 'package:dhansaarathi/app/utils_res/color_helper.dart';
import 'package:dhansaarathi/app/widgets/text_view_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/fund_fullscreen_controller.dart';

class FundFullScreen extends StatelessWidget {
  final FundFullscreenController controller =
      Get.put(FundFullscreenController());

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      back: true,
      title: controller.title,
      child: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: getFundFullScreenContent(),
        ),
      ),
    );
  }

  Widget getFundFullScreenContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          investmentInfo(),
          const SizedBox(height: 16),
          getLineChartWidget(),
          const SizedBox(height: 16),
          investmentSimulator(),
          const SizedBox(height: 16),
          getBarChartWidget(),
          const SizedBox(height: 16),
          actionButtons(),
        ],
      ),
    );
  }

  Widget investmentInfo() {
    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          decoration: TextViewHelper.getBoxDecor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoColumn("Invested",
                  "₹${controller.investedAmount.value.toStringAsFixed(1)}k"),
              Container(
                height: 23,
                width: 1,
                color: Colors.grey.withOpacity(.5),
              ),
              infoColumn("Current Value",
                  "₹${controller.currentValue.value.toStringAsFixed(1)}k"),
              Container(
                height: 23,
                width: 1,
                color: Colors.grey.withOpacity(.5),
              ),
              infoColumn("Total Gain",
                  "₹${controller.totalGain.value.toStringAsFixed(2)}",
                  isNegative: controller.totalGain.value < 0),
            ],
          ),
        ));
  }

  Widget getLineChartWidget() {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(8),
      decoration: TextViewHelper.getBoxDecorTrans(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.show_chart, color: blueMarine, size: 16),
                  Text(" Your Investments  -19.75%",
                      style: TextStyle(color: blueMarine, fontSize: 12)),
                ],
              ),
              const Row(
                children: [
                  Icon(Icons.show_chart, color: orangeMine, size: 16),
                  Text(" Nifty Midcap 150  -12.97%",
                      style: TextStyle(color: orangeMine, fontSize: 12)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Utilities.showToast("DhanSaarathi", "Under construction");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(.1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("NAV",
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          List<String> labels = controller.label;
                          if (value.toInt() < labels.length) {
                            return Text(labels[value.toInt()],
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 10));
                          }
                          return Container();
                        },
                        interval: 1,
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: controller.investmentSpots,
                      isCurved: true,
                      color: blueMarine,
                      barWidth: 1,
                      belowBarData: BarAreaData(show: true),
                      dotData: const FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: controller.niftySpots,
                      isCurved: true,
                      color: orangeMine,
                      barWidth: 1,
                      belowBarData: BarAreaData(show: true),
                      shadow: const Shadow(color: Colors.white30),
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          timeRangeSelector(),
        ],
      ),
    );
  }

  Widget timeRangeSelector() {
    List<String> timeRanges = ["1M", "3M", "6M", "1Y", "3Y", "MAX"];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: TextViewHelper.getBoxDecor(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: timeRanges.map((e) {
          return GestureDetector(
            onTap: () => controller.updateChartData(e),
            child: Obx(
              () => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: controller.selectedPeriod.value == e
                      ? blueMarine
                      : Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(e,
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget getBarChartWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 2.5,
          child: BarChart(
            BarChartData(
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      List<String> labels = [
                        "Saving A/C",
                        "Category Avg.",
                        "Direct Plan"
                      ];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          labels[value.toInt()],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      );
                    },
                    reservedSize: 24,
                  ),
                ),
              ),
              barGroups: controller.barValues.asMap().entries.map((entry) {
                int index = entry.key;
                double value = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: value,
                      width: 30,
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 5,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                  showingTooltipIndicators: [0],
                );
              }).toList(),
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      "₹${controller.barValues[groupIndex]}L",
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget actionButtons() {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Utilities.showToast(
                      "DhanSaarathi", "Sell under construction");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(.9)),
                child:
                    const Text("Sell", style: TextStyle(color: Colors.white)))),
        const SizedBox(width: 10),
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Utilities.showToast(
                      "DhanSaarathi", "Invest under construction");
                },
                style: ElevatedButton.styleFrom(backgroundColor: blueMarine),
                child: const Text("Invest More",
                    style: TextStyle(color: Colors.white)))),
      ],
    );
  }

  Widget infoColumn(String title, String value, {bool isNegative = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                color: isNegative ? Colors.red : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget investmentSimulator() {
    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          decoration: TextViewHelper.getBoxDecor(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("If you invested",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              Slider(
                value: controller.investedAmount.value,
                min: 1000,
                max: 100000,
                // divisions: 20,
                activeColor: blueMarine,
                onChanged: (value) => controller.updateInvestment(value),
              ),
              Text("₹${controller.investedAmount.value.toStringAsFixed(0)}",
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ));
  }
}
