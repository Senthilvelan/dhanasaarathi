import 'package:dhansaarathi/app/utils/utilities.dart';
import 'package:dhansaarathi/app/utils/widgets/background_main.dart';
import 'package:dhansaarathi/app/utils_res/color_helper.dart';
import 'package:dhansaarathi/app/widgets/text_view_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/fund_fullscreen_controller.dart';

class FundFullScreen extends StatelessWidget {
  FundFullScreen({super.key});

  final FundFullscreenController controller =
      Get.put(FundFullscreenController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FundFullscreenController>(builder: (logic) {
      return MainBackground(
        back: true,
        title: "",
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: getFundFullScreenContent(logic),
        ),
      );
    });
  }

  Widget getFundFullScreenContent(FundFullscreenController logic) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitle(),
          const SizedBox(height: 16),
          navOneDayCont(),
          const SizedBox(height: 16),
          investmentInfo(logic),
          const SizedBox(height: 16),
          getLineChartWidget(),
          const SizedBox(height: 24),
          investmentSimulator(logic),
          const SizedBox(height: 16),
          actionButtons(),
        ],
      ),
    );
  }

  Text getTitle() {
    return Text(
      controller.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(color: greyTextClrDove, fontSize: 20),
    );
  }

  Widget investmentInfo(FundFullscreenController controller) {
    return Obx(() => Container(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          decoration: TextViewHelper.getBoxDecor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              infoColumn("Invested",
                  "₹${controller.convertToLakh(controller.investedAmount.value)}"),
              getVerLine(),
              infoColumn("Current Value",
                  "₹${controller.convertToLakh(controller.currentValue.value)}"),
              getVerLine(),
              infoColumn("Total Gain",
                  "₹${controller.convertToLakh(controller.currentValue.value)}",
                  isNegative: true),
            ],
          ),
        ));
  }

  Widget getLineChartWidget() {
    return Container(
      height: 400,
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      alignment: Alignment.center,
      decoration: TextViewHelper.getBoxDecorTrans(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.remove, color: blueMarine, size: 16),
                      Text(" Your Investments  -19.75%",
                          style: TextStyle(color: blueMarine, fontSize: 11)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.remove, color: orangeMine, size: 16),
                      Text(" Nifty Midcap 150  -12.97%",
                          style: TextStyle(color: orangeMine, fontSize: 11)),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Utilities.showToast("DhanSaarathi", "Under construction");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(.09),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("NAV",
                    style: TextStyle(color: greyTextClrDove, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(
              () => LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
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
                      belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              blueMarineLite.withOpacity(.3),
                              greyBorder.withOpacity(.3)
                            ],
                          )),
                      dotData: const FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: controller.niftySpots,
                      isCurved: true,
                      color: orangeMine.withOpacity(.6),
                      barWidth: 1,
                      belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              orangeMineLite.withOpacity(.23),
                              greyBorder.withOpacity(.3)
                            ],
                          )),
                      // shadow: const Shadow(color: red),
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
      padding: const EdgeInsets.all(8),
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
                      : primaryBlackColor87.withOpacity(.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(e,
                    style: TextStyle(
                        color: controller.selectedPeriod.value == e
                            ? greyTextClrDove
                            : greyTextClr,
                        fontSize: 12)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget fundPastReturnsWidget(
      {String amount = "3.6 L", String percent = "355.3"}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "This Fund’s past returns",
              style: TextStyle(
                color: greyTextClrDove,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "₹ $amount",
              style: const TextStyle(
                color: greenApple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Profit % (Absolute Return)",
              style: TextStyle(
                color: greyTextClr,
                fontSize: 14,
              ),
            ),
            Text(
              "$percent%",
              style: const TextStyle(
                color: greyClrDove,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
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
                    backgroundColor: red.withOpacity(.9)),
                child: const Text("Sell",
                    style: TextStyle(color: greyTextClrDove)))),
        const SizedBox(width: 10),
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  Utilities.showToast(
                      "DhanSaarathi", "Invest under construction");
                },
                style: ElevatedButton.styleFrom(backgroundColor: blueMarine),
                child: const Text("Invest More",
                    style: TextStyle(color: greyTextClrDove)))),
      ],
    );
  }

  Widget navOneDayCont() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        navOneDay("Nav", "₹ ${controller.navAmount.value.toStringAsFixed(1)} "),
        const SizedBox(
          width: 12,
        ),
        getVerLine(h: 10.0),
        const SizedBox(
          width: 12,
        ),
        navOneDay(
            "1D", "₹ ${controller.nav1dayAmount.value.toStringAsFixed(1)} "),
        const SizedBox(
          width: 8,
        ),
        getTextLoss(),
      ],
    );
  }

  Widget navOneDay(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(color: greyTextClr, fontSize: 12)),
        const SizedBox(width: 4),
        Text(value,
            style: const TextStyle(
                color: greyTextClrDove,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row getTextLoss({String data = "-3.7", double fsize = 13}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.expand_more, color: red, size: 16),
        // const SizedBox(width: 0),
        Text(
          data,
          style: TextStyle(
            color: red,
            fontSize: fsize,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget infoColumn(String title, String value, {bool isNegative = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(color: greyTextClr, fontSize: 12)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(value,
                style: const TextStyle(
                    color: greyTextClrDove,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            if (isNegative) getTextLoss(data: "14.7", fsize: 15),
          ],
        ),
      ],
    );
  }

  Widget investmentSimulator(FundFullscreenController logic) {
    return Obx(() => Container(
          padding: const EdgeInsets.all(16),
          decoration: TextViewHelper.getBoxDecor(opacity: 0.13),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("If you invested ",
                      style: TextStyle(color: greyTextClrDove, fontSize: 16)),
                  // Text("₹${controller.investedAmount.value.toStringAsFixed(0)}",
                  //     style: const TextStyle(color: greyTextClrDove)),
                  SizedBox(
                    width: 123,
                    // height: 30,
                    child: TextField(
                      textAlign: TextAlign.end,
                      controller: logic.textEditingController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.edit_outlined,
                          color: greyClrDove,
                          size: 17,
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: greyClrDove,
                          width: .5,
                        )),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: greyClrDove,
                            width: .5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: greyTextClr,
                            width: .7,
                          ),
                        ),
                        // contentPadding: EdgeInsets.only(bottom: 1),
                      ),
                      style: const TextStyle(
                          color: greyTextClrDove,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //  toggle
                  const Spacer(),
                  Container(
                      width: 170,
                      alignment: Alignment.centerRight,
                      child: toggleButton(logic)),
                ],
              ),

              const SizedBox(height: 16),
              Slider(
                value: logic.investedAmount.value,
                min: 100000.0,
                max: 1000000.0,
                // divisions: 20,
                activeColor: blueMarine,
                inactiveColor: blueMarineLiter,
                onChanged: (value) => controller.updateInvestment(value),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("₹ 1 L", style: TextStyle(color: Colors.white54)),
                  Text("₹${logic.investedAmount.value.toStringAsFixed(0)}",
                      style: const TextStyle(color: greyTextClr, fontSize: 10)),
                  const Text("₹ 10 L", style: TextStyle(color: Colors.white54)),
                ],
              ),
              const SizedBox(height: 24),
              fundPastReturnsWidget(),
              const SizedBox(height: 24),
              // buildBarChart(),
              getBarChartWidget(),
            ],
          ),
        ));
  }

  Widget toggleButton(FundFullscreenController logic) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: greyBorder),
        // Border similar to the image
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Obx(() {
          return Row(
            children: [
              toggleOption(
                title: "1-Time",
                isSelected: logic.selectedToggleIndex.value == 0,
                onTap: () {
                  logic.onTapToggles(0);
                },
              ),
              toggleOption(
                title: "Monthly SIP",
                isSelected: logic.selectedToggleIndex.value == 1,
                onTap: () {
                  logic.onTapToggles(1);
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget toggleOption(
      {required String title,
      required bool isSelected,
      required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? blueMarine : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? greyTextClrDove : greyBorder,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBarChart() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBar("Saving A/C", controller.calculateReturns(1.19)),
            buildBar("Category Avg.", controller.calculateReturns(3.63)),
            buildBar("Direct Plan", controller.calculateReturns(4.55)),
          ],
        ));
  }

  Widget buildBar(String label, double value) {
    return Column(
      children: [
        Text(
          "₹ ${value.toStringAsFixed(2)}L",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 40,
          height: value * 10, // Adjust height based on value
          color: Colors.green,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white54),
        ),
      ],
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
                              color: greyTextClrDove, fontSize: 12),
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
                      color: greenApple,
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
                        color: greyTextClrDove,
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

  Container getVerLine({double h = 23}) {
    return Container(
      height: h,
      width: 1,
      color: greyBorder,
    );
  }
}
