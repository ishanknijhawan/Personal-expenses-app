import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import './widgets/new_transactions.dart';
import 'models/transactions.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

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
        amount: 150,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transactions(
        id: "two",
        title: "title2",
        amount: 80,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transactions(
        id: "two",
        title: "title2",
        amount: 120,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transactions(
        id: "two",
        title: "title2",
        amount: 29.99,
        date: DateTime.now().subtract(Duration(days: 5))),
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

  bool showChart = false;
  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //specifically declare type to set preferred size property to cupertino nav bar
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    startAddNewTransaction(context);
                  },
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  //FlutterToast not working :(
                  Fluttertoast.showToast(
                      msg: "This is Center Short Toast",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  startAddNewTransaction(context);
                },
              )
            ],
          );
    final txWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height * 2 -
              MediaQuery.of(context).padding.top) *
          0.75,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final pageBody = SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart ',
                      style: Theme.of(context).textTheme.headline6),
                  //adaptive style for android and iOS
                  Switch.adaptive(
                      value: showChart,
                      onChanged: (value) {
                        setState(() {
                          showChart = value;
                        });
                      }),
                ],
              ),
            if (!isLandScape)
              Container(
                padding: EdgeInsets.all(10),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.25,
                width: double.infinity,
                child: Chart(_recentTransactions),
              ),
            if (!isLandScape) txWidget,
            if (isLandScape)
              showChart
                  ? Container(
                      padding: EdgeInsets.all(10),
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      width: double.infinity,
                      child: Chart(_recentTransactions),
                    )
                  : txWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: SafeArea(child: pageBody),
          )
        : Scaffold(
            appBar: appBar,
            body: SafeArea(
              child: pageBody,
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.deepPurple,
              shape: CircularNotchedRectangle(),
              child: Container(
                height: appBar.preferredSize.height,
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Sending Message"),
                          ));
                        })
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Colors.deepOrangeAccent,
                    tooltip: 'Add',
                    onPressed: () {
                      startAddNewTransaction(context);
                    },
                  )
            // : FloatingActionButton.extended(
            //     onPressed: () {
            //       startAddNewTransaction(context);
            //     },
            //     label: Text('Add Transaction'),
            //     icon: Icon(Icons.translate),
            //   ),
            );
  }
}
