import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ljm/pages/homepage/sales/controller.dart';
import 'package:ljm/widgets/charts.dart';

class OmsetSales extends StatelessWidget {
  const OmsetSales(this.c, this.dechart, {this.touchedGroupIndex = -1, super.key});
  final int touchedGroupIndex;
  final List<XBarData2> dechart;
  final DBSalesController c;

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

    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Obx(() => BarChart(BarChartData(
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
                showTitles: false,
                reservedSize: 30,
                getTitlesWidget: (value, meta) => Text(value.toString(), textAlign: TextAlign.left),
              ),
            ),
            topTitles: const AxisTitles(drawBelowEverything: true, sideTitles: SideTitles(showTitles: false)),
          )))),
    );
  }
}

/* class OmsetSales extends StatefulWidget {
  const OmsetSales({Key? key}) : super(key: key);
  @override
  State<OmsetSales> createState() => _OmsetSalesState();
}

class _OmsetSalesState extends State<OmsetSales> {
  List<charts.Series<dynamic, String>> seriesList = <charts.Series<dynamic, String>>[];
  bool animate = true;
  double totalomset = 0;
  bool localloading = true;
  var controller = Get.find<DBAdminController>();
  List<charts.Series<Omset, String>> _getdata() {
    return [
      charts.Series<Omset, String>(
        id: 'Omset',
        domainFn: (Omset sales, _) => sales.bulan.toString(),
        measureFn: (Omset sales, _) => sales.total?.toInt(),
        data: omsetchart.omset,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.blueAccent),
      ),
      charts.Series<Omset, String>(
        id: 'Pelunasan',
        domainFn: (Omset sales, _) => sales.bulan.toString(),
        measureFn: (Omset sales, _) => sales.total?.toInt(),
        data: omsetchart.pelunasan,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      charts.Series<Omset, String>(
        id: 'Sisa JT',
        domainFn: (Omset sales, _) => sales.bulan.toString(),
        measureFn: (Omset sales, _) => sales.total?.toInt(),
        data: omsetchart.tempo,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];
  }

  _initData() async {
    dp('init: OmsetSales');
    seriesList = _getdata();
    dp('seriesList => ${seriesList.length}');
    setState(() {
      localloading = false;
      ;
    });
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }
 */
