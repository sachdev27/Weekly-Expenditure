import 'package:flutter/foundation.dart';

class Transaction {
  final String id; // transaction ID
  final String title; // transaction Name
  final double amount; // transaction amount
  final DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
