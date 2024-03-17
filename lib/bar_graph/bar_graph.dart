import 'package:bar_graph/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List<double> weeklySummary;

  const MyBarGraph({super.key, required this.weeklySummary});

  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        sunAmount: weeklySummary[0],
        monAmount: weeklySummary[1],
        tueAmount: weeklySummary[2],
        wedAmount: weeklySummary[3],
        thuAmount: weeklySummary[4],
        friAmount: weeklySummary[5],
        satAmount: weeklySummary[6]);

    myBarData.initializeBarData();
    return Center(
      child: SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              maxY: 100,
              minY: 0,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(
                show: true,
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true, getTitlesWidget: getBottomTiles),
                ),
              ),
              barGroups: myBarData.barData
                  .map(
                    (data) => BarChartGroupData(x: data.x, barRods: [
                      BarChartRodData(
                          toY: data.y,
                          color: Colors.grey,
                          width: 25,
                          borderRadius: BorderRadius.circular(4),
                          backDrawRodData: BackgroundBarChartRodData(
                              show: true, toY: 100, color: Colors.grey[200]))
                    ]),
                  )
                  .toList(),
            ),
          )),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('S', style: style);
      break;
    case 2:
      text = const Text('M', style: style);
      break;
    case 3:
      text = const Text('T', style: style);
      break;
    case 4:
      text = const Text('W', style: style);
      break;
    case 5:
      text = const Text('T', style: style);
      break;
    case 6:
      text = const Text('F', style: style);
      break;
    case 7:
      text = const Text('S', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
