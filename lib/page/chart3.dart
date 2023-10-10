import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart3 extends StatefulWidget {
  const Chart3({super.key});

  @override
  State<Chart3> createState() => _Chart3State();
}

class _Chart3State extends State<Chart3> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Pertumbuhan Ekonomi Provinsi Kepulauan Bangka Belitung',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(
            color: Color(0xFF659dd4),
            thickness: 2,
          ),
        ),
        SizedBox(
          height: 200,
          child: SfCartesianChart(
            //zoomPanBehavior: _zoomPanBehavior,
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0.2),
              minorGridLines: const MinorGridLines(width: 0),
              borderWidth: 0,
              labelStyle: const TextStyle(
                color: Colors.white,
              ),
            ),
            primaryYAxis: NumericAxis(isVisible: false, visibleMinimum: -10),
            series: <LineSeries<InflasiData, String>>[
              LineSeries<InflasiData, String>(
                  // Bind data source
                  dataSource: <InflasiData>[
                    InflasiData('Tw I \'22', -4.44),
                    InflasiData('Tw II \'22', 5.31),
                    InflasiData('Tw III \'22', 1.12),
                    InflasiData('Tw IV \'22', 4.40),
                    InflasiData('Tw I \'23', -4.51),
                  ],
                  color: const Color(0xFFe9df59),
                  markerSettings: const MarkerSettings(
                      isVisible: true, color: Colors.white, borderWidth: 0),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    color: Colors.black,
                    opacity: 0.2,
                  ),
                  xValueMapper: (InflasiData data, _) => data.bulan,
                  yValueMapper: (InflasiData data, _) => data.nilai),
            ],
          ),
        ),
      ],
    );
  }
}

class InflasiData {
  InflasiData(this.bulan, this.nilai);
  final String bulan;
  final double nilai;
}
