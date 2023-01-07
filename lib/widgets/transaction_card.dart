import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paisa_tracker/model/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: transaction.collectedAmount >= transaction.rentAmount
                  ? Colors.green
                  : Colors.red,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Collected',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Text('₹${transaction.collectedAmount.toPrecision(2)}',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total : ₹${transaction.rentAmount}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.start),
                const SizedBox(
                  height: 5,
                ),
                Text(
                    'Per Head : ₹${(transaction.rentAmount / transaction.playersPlayed.length).toPrecision(2)}',
                    textAlign: TextAlign.start),
              ],
            ),
          ),
          const Spacer(),
          Text(DateFormat.yMMMd().format(transaction.dateTime)),
        ]),
      ),
    );
  }
}
