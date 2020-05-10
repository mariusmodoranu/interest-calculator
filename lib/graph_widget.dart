import 'package:calculator/model/result_model.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<ResultModel> results;
  final bool animate;

  LineChartWidget(this.results, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Investment graph'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: charts.LineChart(_createSeriesList(),
            animate: animate,
            defaultRenderer: charts.LineRendererConfig(includePoints: true),
            behaviors: [new charts.SeriesLegend()]),
      ),
    );
  }

  _createSeriesList() {
    return [
      new charts.Series<ResultModel, int>(
        id: 'Total value',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (ResultModel result, _) => result.year,
        measureFn: (ResultModel result, _) => result.investmentValue,
        data: results,
      ),
      new charts.Series<ResultModel, int>(
        id: 'Contributions',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ResultModel result, _) => result.year,
        measureFn: (ResultModel result, _) => result.contributions,
        data: results,
      ),
      new charts.Series<ResultModel, int>(
        id: 'Profit',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (ResultModel result, _) => result.year,
        measureFn: (ResultModel result, _) => result.profit,
        data: results,
      )
    ];
  }
}
