import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: theme.textTheme.headline6,
                ),
                Spacer(),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              Transaction transaction = _transactions[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${transaction.amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: theme.textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transaction.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          textColor: theme.errorColor,
                          label: Text('Delete'),
                          onPressed: () {
                            _deleteTransaction(transaction.id);
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: theme.errorColor,
                          onPressed: () {
                            _deleteTransaction(transaction.id);
                          },
                        ),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
