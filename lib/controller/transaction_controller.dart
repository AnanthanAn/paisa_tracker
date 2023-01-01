import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa_tracker/model/transaction.dart';

class TransactionController extends GetxController{
  List<Transaction> transactions = <Transaction>[].obs;
  late double perHeadRate;

  Future fetchTransactionsFromHive() async{
    transactions.clear();
    var box = Hive.box<Transaction>('transactions');
    transactions.addAll(box.values);
  }

  @override
  void onInit() {
    fetchTransactionsFromHive();
    super.onInit();
  }

  Future addTransaction(Transaction transaction) async{
    var box = Hive.box<Transaction>('transactions');
    box.add(transaction);
    fetchTransactionsFromHive();
  }

  void updateTransactionPayment({required int index,required Transaction transaction}){
    var box = Hive.box<Transaction>('transactions');
    box.putAt(index, transaction);
    fetchTransactionsFromHive();
  }
}