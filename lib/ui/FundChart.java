import 'package:hive/hive.dart';

        part 'mutual_fund.g.dart';

@HiveType(typeId: 0)
class MutualFund extends HiveObject {
    @HiveField(0)
    String name;

    @HiveField(1)
    double nav;

    @HiveField(2)
    double returns;

    @HiveField(3)
    double aum;

    MutualFund({required this.name, required this.nav, required this.returns, required this.aum});
}
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FundChart extends StatelessWidget {
  final List<FlSpot> dataPoints;

  FundChart({required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: dataPoints,
          isCurved: true,
          colors: [Colors.blue],
          barWidth: 3,
        ),
      ],
    ));
  }
}
