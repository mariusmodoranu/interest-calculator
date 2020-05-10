import 'package:calculator/model/result_model.dart';
import 'package:calculator/table_widget.dart';
import 'package:flutter/material.dart';

import 'graph_widget.dart';
import 'model/entry_model.dart';

class Result extends StatelessWidget {
  final EntryModel model;

  Result(this.model);

  @override
  Widget build(BuildContext context) {
    List<ResultModel> results = model.calculateResultModel();
    ResultModel lastYearResult = results.last;
    return Container(
      color: Colors.amberAccent,
      padding: const EdgeInsets.only(right: 80, left: 80, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text("Investment value:"),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  child: Text(
                      "\$${lastYearResult.investmentValue.toStringAsFixed(2)}"),
                ),
                flex: 1,
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text("Contributions:"),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  child: Text(
                      "\$${lastYearResult.contributions.toStringAsFixed(2)}"),
                ),
                flex: 1,
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text("Profit:"),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  child: Text("\$${lastYearResult.profit.toStringAsFixed(2)}"),
                ),
                flex: 1,
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: RaisedButton(
                    child: Center(child: Text("See Graph")),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LineChartWidget(results)),
                      );
                    },
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: RaisedButton(
                    child: Center(child: Text("See Table")),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TableWidget(results)),
                      );
                    },
                  ),
                ),
                flex: 1,
              )
            ],
          ),
        ],
      ),
    );
  }
}
