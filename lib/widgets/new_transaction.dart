import 'package:expenses_planner_app/widgets/adaptive_flat_%20button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/adaptive_flat_ button.dart';
import 'dart:io';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction) {
    print("Constructor NewTransaction Widget");
  }

  @override
  _NewTransactionState createState() {
    print("Createstate newtransaction widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print("Consstructor newtransaction state");
  }

  @override
  void initState() {
    super.initState();
    print("Initstate()");
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print("didUpdateWidget()");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("dispose()");
    super.dispose();
  }

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    // Then executes a method when the user chooses a date in the "Future"
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            // viewInsetes gets the height of the overlapping objects, in this case: the soft keyboard
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // when maually triggering function using anonymous functions, we must call function and not just send pointer
              ),
              Container(
                height: 70,
                child: Row(children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "No Date Chosen!"
                        : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"),
                  ),
                  AdaptiveFlatButton("Choose Date!", _presentDatePicker),
                ]),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _presentDatePicker,
                      color: Theme.of(context).primaryColor,
                      child: Text("Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold)))
                  : RaisedButton(
                      onPressed: _submitData,
                      child: Text("Add Transaction"),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
