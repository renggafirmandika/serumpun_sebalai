import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart4 extends StatefulWidget {
  const Chart4({super.key});

  @override
  State<Chart4> createState() => _Chart4State();
}

class _Chart4State extends State<Chart4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Perkembangan Inflasi Kota Tanjungpandan (m-to-m), 2023',
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
            primaryYAxis: NumericAxis(isVisible: false, visibleMinimum: -1),
            series: <LineSeries<InflasiData, String>>[
              LineSeries<InflasiData, String>(
                  // Bind data source
                  dataSource: <InflasiData>[
                    InflasiData('Jan', 1.71),
                    InflasiData('Feb', -0.26),
                    InflasiData('Mar', 0.70),
                    InflasiData('Apr', 0.19),
                    InflasiData('May', 1.28),
                    InflasiData('Jun', -0.03)
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
