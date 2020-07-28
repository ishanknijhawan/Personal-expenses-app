import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transactions.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    //doubt in this .generate function, watch this video again
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalScore = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalScore += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalScore
      };
    });
  }

  double getTotalScore() {
    var totalScoreGT = 0.0;
    for (var i = 0; i < groupedTransactionValues.length; i++) {
      totalScoreGT += groupedTransactionValues[i]['amount'];
    }
    return totalScoreGT;
  }

  //according to max
  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print('grouped transaction values are...');
    print(groupedTransactionValues);
    return Container(
      height: 150,
      child: Card(
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: groupedTransactionValues.map((e) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      e['day'],
                      e['amount'],
                      maxSpending == 0.0
                          ? 0.0
                          : (e['amount'] as double) / maxSpending),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
