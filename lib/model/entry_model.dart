import 'package:calculator/model/result_model.dart';

enum Periods { YEARLY, QUARTERLY, MONTHLY, WEEKLY }

class EntryModel {
  final double startBalance;
  final double annualReturn;
  final int years;
  final double addition;
  final Periods period;

  EntryModel(this.startBalance, this.annualReturn, this.years, this.addition,
      this.period);

  calculateResultModel() {
    List<ResultModel> results = List();
    results.add(ResultModel(startBalance, startBalance, 0, 0));
    for (int i = 0; i < years; i++) {
      int multiplication;
      switch (period) {
        case Periods.YEARLY:
          multiplication = 1;
          break;
        case Periods.QUARTERLY:
          multiplication = 4;
          break;
        case Periods.MONTHLY:
          multiplication = 12;
          break;
        case Periods.WEEKLY:
          multiplication = 52;
          break;
      }
      double contrib = results.last.contributions + multiplication * addition;
      double invValue =
          (results.last.investmentValue + multiplication * addition) *
              (1 + annualReturn / 100);
      double profit = invValue - contrib;
      results.add(ResultModel(invValue, contrib, profit, i + 1));
    }
    return results;
  }
}
