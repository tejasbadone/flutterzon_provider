import 'package:amazon_clone_flutter/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../constants/utils.dart';
import '../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    if (mounted) {
      setState(() {});
    }
  }

  List<ColumnSeries<Sales, String>> _getDefaultCategory() {
    return <ColumnSeries<Sales, String>>[
      ColumnSeries<Sales, String>(
        dataSource: earnings!,
        xValueMapper: (Sales data, _) => data.label,
        yValueMapper: (Sales data, _) => data.earning,
        pointColorMapper: (Sales data, _) => data.pointColor,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Total Earnings - ₹${formatLakhs(totalSales!)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    width: double.infinity,
                    child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          labelRotation: 270,
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          isVisible: true,
                          placeLabelsNearAxisLine: true,
                          numberFormat: NumberFormat.compact(locale: 'en_IN'),
                          // labelRotation: 270,
                          minimum: 0,
                          maximum: (totalSales! * 3),
                          majorGridLines: const MajorGridLines(width: 0.5),
                        ),
                        series: _getDefaultCategory()),
                  ),
                ),
              ],
            ),
          );
  }
}
