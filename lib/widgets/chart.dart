import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class _TxValues {
  String day;
  double amount;

  _TxValues(
    this.day,
    this.amount,
  );
}

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<_TxValues> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = recentTransactions
          .where((tx) =>
              tx.date.day == weekDay.day &&
              tx.date.month == weekDay.month &&
              tx.date.year == weekDay.year)
          .fold(0, (sum, tx) => sum + tx.amount);

      return _TxValues(
        DateFormat.E().format(weekDay)[0],
        totalSum,
      );
    });
  }

  double get totalSpending => groupedTransactionValues.fold(
      0, (total, value) => total + value.amount);

  Chart(this.recentTransactions);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data.day,
                data.amount,
                totalSpending == 0.0
                    ? 0.0
                    : data.amount / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
