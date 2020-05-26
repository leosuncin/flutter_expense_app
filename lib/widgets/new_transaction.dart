import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddTransaction;

  NewTransaction(this.onAddTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectedDate;

  void handleSubmit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || selectedDate == null) return;

    widget.onAddTransaction(title, amount, selectedDate);

    Navigator.of(context).pop();
  }

  Future<void> presentDatePicker() async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) return;

    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const double padding = 10;

    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: padding,
            left: padding,
            right: padding,
            bottom: MediaQuery.of(context).viewInsets.bottom + padding,
          ),
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
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(selectedDate != null
                          ? 'Picked date ${DateFormat.yMd().format(selectedDate)}'
                          : 'No date chosen!'),
                    ),
                    if (Platform.isAndroid)
                      FlatButton(
                        child: Text(
                          'Choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        textColor: theme.primaryColor,
                        onPressed: presentDatePicker,
                      ),
                    if (Platform.isIOS)
                      CupertinoButton(
                          child: Text(
                            'Choose date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: presentDatePicker)
                  ],
                ),
              ),
              if (Platform.isAndroid)
                RaisedButton(
                  child: Text('Add transaction'),
                  color: theme.primaryColor,
                  textColor: theme.textTheme.button.color,
                  onPressed: handleSubmit,
                ),
              if (Platform.isIOS)
                CupertinoButton.filled(
                  child: Text('Add transaction'),
                  onPressed: handleSubmit,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
