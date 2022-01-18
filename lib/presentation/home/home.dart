import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String namePage = '/Home';

  static void goHomePage(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(namePage, (route) => false, arguments: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        SizedBox(
            height: 250,
            child: SfCartesianChart(
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  // Initialize line series
                  LineSeries<SalesData, String>(
                      dataSource: [
                        SalesData('0', 20),
                        SalesData('0.1', 45),
                        SalesData('5', 28),
                        SalesData('10', 34),
                        SalesData('15', 32),
                        SalesData('20', 40),
                        SalesData('25', 32),
                        SalesData('30', 20),
                        SalesData('31', 20),
                        SalesData('50', 20),
                        SalesData('60', 20),
                        SalesData('70', 20),
                        SalesData('90', 20),
                        SalesData('100', 20),
                        SalesData('130', 22),
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      // Render the data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ])),
      ],
    )));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double? sales;
}
