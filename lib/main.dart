import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:module_3/widget/chart.dart';
import 'package:module_3/widget/new_transaction.dart';
import 'package:module_3/widget/transaction_list.dart';
import './models/transaction.dart';
import './widget/chart.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.orange,
          errorColor: Colors.red,
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(fontFamily: 'Poppins', fontSize: 20),
              button: TextStyle(color: Colors.white)),
          // accentColor: Colors.black,
          // backgroundColor: Colors.grey,
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'Josefinsans',
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.normal)),
            // backgroundColor: Colors.black,
            // iconTheme: IconThemeData(color: Colors.green),
          )),
      title: 'Flutter Expense App',
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _showChart = false;

  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 29.90, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Party', amount: 52.50, date: DateTime.now()),
  ];

  List<Transaction> get _recenttransaction {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newtx = new Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: chosenDate);

    setState(() {
      _userTransactions.add(newtx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

// --------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("\₹ Expenses"),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context)),
      ],
    );
    final txList = Container(
        child: TransactionList(
          transactions: _userTransactions,
          deleteTransaction: _deleteTransaction,
        ),
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.8);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Show Chart"),
                Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ]),
            if (!isLandscape)
              Container(
                  child: Chart(recentTransaction: _recenttransaction),
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3),
            if (!isLandscape) txList,
            if (isLandscape)
              _showChart == true
                  ? Container(
                      child: Chart(recentTransaction: _recenttransaction),
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.62)
                  : txList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
