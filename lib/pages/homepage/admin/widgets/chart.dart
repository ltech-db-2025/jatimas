import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/admin/controller.dart';
import 'package:ljm/widgets/charts.dart';

class OmsetGlobal extends StatelessWidget {
  const OmsetGlobal(this.c, this.dechart, {this.touchedGroupIndex = -1, super.key});
  final int touchedGroupIndex;
  final List<XBarData2> dechart;
  final DBAdminController c;

  @override
  Widget build(BuildContext context) {
    BarChartGroupData generateBarGroup(
      int x,
      double omset,
      double pelunasan,
      double tempo,
    ) {
      return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: omset,
            color: Colors.blue,
            width: 6,
          ),
          BarChartRodData(
            toY: pelunasan,
            color: Colors.green,
            width: 6,
          ),
          BarChartRodData(
            toY: tempo,
            color: Colors.red,
            width: 6,
          ),
        ],
        showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
      );
    }

    return Obx(() => BarChart(BarChartData(
        barGroups: dechart.asMap().entries.map((e) {
          //final index = e.key;
          final data = e.value;
          return generateBarGroup(
            data.bulan,
            data.omset,
            data.pelunasan,
            data.tempo,
          );
        }).toList(),
        alignment: BarChartAlignment.spaceBetween,
        borderData: FlBorderData(
          show: false,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.black.withValues(alpha: 0.2),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            drawBelowEverything: true,
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toString(),
                  textAlign: TextAlign.left,
                );
              },
            ),
          ),
        ))));
  }
}
