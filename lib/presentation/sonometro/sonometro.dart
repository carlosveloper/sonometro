import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:miapp/model/sensor.dart';
import 'package:miapp/state/provider/sonometro_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

var sonoMetroChangeNotifierProvider = ChangeNotifierProvider((ref) {
  return SonoMetrorovider();
});

class SonoMetroPage extends ConsumerStatefulWidget {
  const SonoMetroPage({Key? key}) : super(key: key);

/*   @override
  State<SonoMetroPage> createState() => _SonoMetroPageState();

 */

  @override
  _SonoMetroPageState createState() => _SonoMetroPageState();
}

class _SonoMetroPageState extends ConsumerState<SonoMetroPage> {
  late SonoMetrorovider sonoApp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    if (sonoApp.inicie) sonoApp.streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sonoApp = ref.watch(sonoMetroChangeNotifierProvider);
    sonoApp.listen();
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SfRadialGauge(
                axes: [
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    pointers: <GaugePointer>[
                      NeedlePointer(
                          value: sonoApp.valoresSensor.isEmpty
                              ? 0
                              : sonoApp.valoresSensor.first,
                          needleLength: 0.8,
                          enableAnimation: true),
                    ],
                    ranges: [
                      GaugeRange(
                          startValue: 0,
                          endValue: 25,
                          color: Colors.green,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 25,
                          endValue: 50,
                          color: Colors.yellow,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 50,
                          endValue: 75,
                          color: Colors.orange,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 75,
                          endValue: 100,
                          color: Colors.red,
                          startWidth: 10,
                          endWidth: 10),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                              child: Text(
                                  sonoApp.valoresSensor.isEmpty
                                      ? '0'
                                      : sonoApp.valoresSensor.first.toString() +
                                          'dB',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                          angle: 90,
                          positionFactor: 0.5)
                    ],
                  ),
                ],
                title: GaugeTitle(
                    text: 'Speedometer',
                    textStyle: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold))),
            SizedBox(
                height: 250,
                child: SfCartesianChart(
                    title: ChartTitle(text: ''),
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries>[
                      // Initialize line series
                      LineSeries<SensorModel, String>(
                        dataSource: sonoApp
                            .listaSensor /* [z
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
                          ] */
                        ,
                        xValueMapper: (SensorModel sales, _) =>
                            DateFormat('HH:mm a').format(sales.tiempoLectura),
                        yValueMapper: (SensorModel sales, _) =>
                            double.parse(sales.valorRuido.toString()),
                        legendItemText: 'dd',
                        // Render the data label
                        enableTooltip: true,
                        markerSettings: MarkerSettings(isVisible: true),

                        name: '',
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                        ),
                      )
                    ])),
          ],
        ),
      ),
    );
  }
}
