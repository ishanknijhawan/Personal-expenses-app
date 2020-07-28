import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import './widgets/new_transactions.dart';
import 'models/transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColorDark: Color(0xffb74093),
        fontFamily: 'Ubuntu',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      elevation: 10,
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  final List<Transactions> _userTransactions = [
    Transactions(
        id: "one", title: "title1", amount: 10.56, date: DateTime.now()),
    Transactions(
        id: "two",
        title: "title2",
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transactions(
        id: "two",
        title: "title2",
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transactions(
        id: "two",
        title: "title2",
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transactions(
        id: "two",
        title: "title2",
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transactions(
        id: "two",
        title: "title2",
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 1))),
  ];

  List<Transactions> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    print('Amount is $amount');
    final value = Transactions(
        amount: amount,
        date: date,
        id: DateTime.now().toString(),
        title: title);

    setState(() {
      _userTransactions.add(value);
      print("getting here");
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startAddNewTransaction(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                height: 150,
                width: double.infinity,
                child: Chart(_recentTransactions),
              ),
              TransactionList(_userTransactions, _deleteTransaction)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          startAddNewTransaction(context);
        },
        label: Text('Add Transaction'),
        icon: Icon(Icons.translate),
      ),
    );
  }
}
