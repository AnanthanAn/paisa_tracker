import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paisa_tracker/model/transaction.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
  TransactionWidget(
      {required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: transaction.collectedAmount >= transaction.rentAmount ? Colors.green : Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text('${transaction.collectedAmount}',textAlign: TextAlign.center),
        ),
      ),
      title: Text('Total : ₹${transaction.rentAmount.toString()}',),
      subtitle:
          Text('Per Head : ₹${calculatePerHeadRate(transaction).toString()}'),
    );
  }

  double calculatePerHeadRate(Transaction transaction) {
    var count = transaction.playersPlayed.length;
    return (transaction.rentAmount / count).toPrecision(2);
  }
}
