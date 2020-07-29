import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transactions.dart';

class TransactionList extends StatefulWidget {
  final List<Transactions> transactions;
  final Function deleteTransactions;

  TransactionList(this.transactions, this.deleteTransactions);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    if (widget.transactions.length == 0) {
      return Container(
        child: Column(
          children: <Widget>[
            Text(
              'No transactions added',
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Image.asset('assets/images/card.png'),
            ),
          ],
        ),
      );
    } else if (widget.transactions.length < 3) {
      return Container(
        height: 500,
        child: ListView.builder(
          itemCount: widget.transactions.length,
          itemBuilder: (context, index) {
            return Container(
              width: double.infinity,
              height: 70,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Card(
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                        border: Border.all(
                          //color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '\$${widget.transactions[index].amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          //color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            widget.transactions[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            DateFormat.yMMMd()
                                .format(widget.transactions[index].date),
                            style: TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(120, 0, 0, 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () {
                          widget.deleteTransactions(
                              widget.transactions[index].id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        child: ListView.builder(
          itemCount: widget.transactions.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                          '\$${widget.transactions[index].amount.toStringAsFixed(2)}'),
                    ),
                  ),
                ),
                title: Text(widget.transactions[index].title,
                    style: Theme.of(context).textTheme.headline6),
                subtitle: Text(
                  DateFormat.yMMMd().format(widget.transactions[index].date),
                ),
                trailing: IconButton(
                  color: Colors.red,
                  onPressed: () {
                    widget.deleteTransactions(widget.transactions[index].id);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
