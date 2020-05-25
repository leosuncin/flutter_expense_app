import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransaction;

  NewTransaction(this.onAddTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void handleSubmit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) return;

    widget.onAddTransaction(title, amount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => handleSubmit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => handleSubmit(),
            ),
            FlatButton(
              child: Text('Add transaction'),
              textColor: Theme.of(context).primaryColor,
              onPressed: handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
