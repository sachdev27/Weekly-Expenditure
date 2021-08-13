import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:module_3/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList({Key key, this.transactions, this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  "No transaction added yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // height: 200,
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\₹ ${transactions[index].amount}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                  title: Text(transactions[index].title),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          textColor: Theme.of(context).errorColor)
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}

// return Card(
//                   // color: Colors.black,
//                   elevation: 5,
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         margin:
//                             EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                           color: Theme.of(context).primaryColorDark,
//                           width: 1,
//                         )),
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           // '\$ ${transactions[index].amount}',
//                           // '\₹ ${'hello'} ${transactions[index].amount}',
//                           '\₹ ${transactions[index].amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Colors.red),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             transactions[index].title,
//                             // style: TextStyle(
//                             //   fontSize: 16,
//                             //   fontWeight: FontWeight.bold,
//                             //   color: Theme.of(context).primaryColor,
//                             // ),
//                             style: Theme.of(context).textTheme.title,
//                           ),
//                           Text(
//                             DateFormat.yMMMMEEEEd()
//                                 .format(transactions[index].date),
//                             style: TextStyle(color: Colors.grey, fontSize: 11),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 );
