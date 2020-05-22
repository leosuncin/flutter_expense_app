import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function _onSubmitTransaction;

  NewTransaction(this._onSubmitTransaction);

  void _handleSubmit() {
    try {
      final title = titleController.text;
      final amount = amountController.text;

      if (title.isEmpty || amount.isEmpty) return;

      _onSubmitTransaction(title, double.parse(amount).abs());
    } catch (e) {
      print(e);
    }
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
              onSubmitted: (_) => _handleSubmit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _handleSubmit(),
            ),
            FlatButton(
              child: Text('Add transaction'),
              textColor: Colors.purple,
              onPressed: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
