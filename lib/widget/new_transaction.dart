import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

// -----------------------------------------------

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enterdTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enterdTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addtx(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

// ----------------------------------------------------------

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

// --------------------------------------------------------------------

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
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                // onChanged: (val) {
                //   titleInput = val;
                // }
                controller: _titleController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                decoration: InputDecoration(labelText: "Transaction Amount"),
                // onChanged: (val) => amountInput = val,
                controller: _amountController,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? "No Date Chosen"
                          : 'Picked Date : ${DateFormat.MMMEd().format(_selectedDate)}'),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: _presentDatePicker,
                        child: Text("Choose Date",
                            style: TextStyle(fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    // padding: EdgeInsets.all(0),
                    onPressed: _submitData,
                    child: Text("Add Transaction"),
                    // color: Colors.grey[200],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
