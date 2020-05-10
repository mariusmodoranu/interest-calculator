import 'package:calculator/model/result_model.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatelessWidget {
  final List<ResultModel> results;

  TableWidget(this.results);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Investment table'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 40,
          columns: [
            DataColumn(label: Text("Year")),
            DataColumn(label: Text("Total")),
            DataColumn(label: Text("Contributions")),
            DataColumn(label: Text("Profit"))
          ],
          rows: results
              .map(
                (result) => DataRow(cells: [
                  DataCell(
                    Container(width: 30, child: Text(result.year.toString())),
                  ),
                  DataCell(
                    Text(result.investmentValue.toStringAsFixed(2)),
                    onTap: () {
                      // write your code..
                    },
                  ),
                  DataCell(
                    Container(
                        width: 70,
                        child: Text(result.contributions.toStringAsFixed(2))),
                  ),
                  DataCell(
                    Text(result.profit.toStringAsFixed(2)),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}
