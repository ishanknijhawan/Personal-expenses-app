// import 'package:flutter/material.dart';
// import '../models/transactions.dart';
// import '../widgets/transaction_list.dart';

// import 'new_transactions.dart';

// final List<Transactions> _userTransactions = [
//   Transactions(id: "one", title: "title1", amount: 50.56, date: DateTime.now()),
//   Transactions(id: "two", title: "title2", amount: 10, date: DateTime.now()),
// ];

// class UserTransaction extends StatefulWidget {
//   @override
//   _UserTransactionState createState() => _UserTransactionState();
// }

// class _UserTransactionState extends State<UserTransaction> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         NewTransaction(_addTransaction),
//         TransactionList(_userTransactions),
//       ],
//     );
//   }

//   void _addTransaction(String title, double amount) {
//     print('Amount is $amount');
//     final value = Transactions(
//         amount: amount,
//         date: DateTime.now(),
//         id: DateTime.now().toString(),
//         title: title);

//     setState(() {
//       _userTransactions.add(value);
//       print("getting here");
//     });
//   }

// }
