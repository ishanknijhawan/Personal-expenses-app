import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.title),
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.purple),
              ),
              hintText: 'Enter the title',
              labelText: 'Title',
            ),
            controller: titleController,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.attach_money),
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal),
              ),
              hintText: 'Enter the amount',
              labelText: 'Amount',
            ),
            controller: amountController,
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(50, 10, 10, 10),
          child: Row(
            //one way is to use mainAxisAlignment like so below
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //other way you can do is use Expanded widget in picked date text :)
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}',
                ),
              ),
              FlatButton(
                onPressed: initDatePicker,
                child: Text(
                  'Chose date',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).buttonColor,
            child: Text('Add Transaction'),
            onPressed: () {
              print(titleController.text);
              print(amountController.text);
              widget.addTransaction(
                titleController.text,
                double.parse(amountController.text),
                _selectedDate,
              );
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  void initDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }
}
