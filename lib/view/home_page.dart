import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paisa_tracker/controller/player_controller.dart';
import 'package:paisa_tracker/controller/transaction_controller.dart';
import 'package:paisa_tracker/model/player.dart';
import 'package:paisa_tracker/model/transaction.dart';
import 'package:paisa_tracker/widgets/player_select_tile.dart';
import 'package:paisa_tracker/widgets/transaction_card.dart';
import 'package:paisa_tracker/widgets/transaction_widget.dart';

import '../model/player.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  final playerController = Get.put(PlayerController());
  final transactionController = Get.put(TransactionController());

  List<Player> selectedPlayers = <Player>[];
  List<Player> paidPlayers = <Player>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paisa Tracker'),
      ),
      body: GetX<TransactionController>(builder: (controller) {
        return Align(
          alignment: Alignment.topCenter,
          child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: controller.transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    openTransactonBottomsheet(
                        index, controller.transactions[index]);
                  },
                  child: TransactionCard(
                    transaction: controller.transactions[index],
                  ),
                );
              }),
        );
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              openAddPlayerBottomsheet();
            },
            child: const Icon(Icons.man),
          ),
          const SizedBox(
            width: 8,
          ),
          FloatingActionButton(
            onPressed: () {
              openAddMatchBottomsheet();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void openAddMatchBottomsheet() {
    Get.bottomSheet(
      Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Add Match',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              buildAmount(),
              const SizedBox(height: 8),
              buildDate(),
              GetX<PlayerController>(builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.players.length,
                    itemBuilder: (BuildContext context, int index) =>
                        PlayerSelectTile(
                      isChecked: false,
                      player: controller.players[index],
                      isSelected: (bool isChecked) {
                        if (isChecked) {
                          selectedPlayers.add(controller.players[index]);
                        }
                      },
                    ),
                  ),
                );
              }),
              buildAddMatchButton()
              //buildAddButton(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void openTransactonBottomsheet(int indexTrans, Transaction transaction) {
    Get.bottomSheet(
      Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Add Payment Details', textAlign: TextAlign.center),
              const SizedBox(height: 20),
              //buildName(),
              buildAmount(transaction: transaction),
              const SizedBox(height: 8),
              buildDate(),
              Expanded(
                child: ListView.builder(
                    itemCount: transaction.playersPlayed.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool _isPaidAlready = false;
                      transaction.playersPaid.forEach((element) {
                        debugPrint(
                            '-----------------${element.name == transaction.playersPlayed[index].name}--------------------------------');
                        _isPaidAlready = element.name ==
                            transaction.playersPlayed[index].name;
                      });
                      debugPrint(
                          '------------------fgf------------${transaction.playersPaid.map((item) => item.name).contains(transaction.playersPlayed[index].name)}---------------------------------------------');
                      return PlayerSelectTile(
                        player: transaction.playersPlayed[index],
                        isChecked: transaction.playersPaid
                            .map((item) => item.name)
                            .contains(transaction.playersPlayed[index].name),
                        isSelected: (bool isChecked) {
                          if (isChecked) {
                            paidPlayers.add(transaction.playersPlayed[index]);
                          }
                        },
                      );
                    }),
              ),
              buildUpdateMatchButton(indexTrans, transaction)
              //buildAddButton(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void openAddPlayerBottomsheet() {
    Get.bottomSheet(
      Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Add Player',
              ),
              const SizedBox(height: 20),
              buildName(),
              Spacer(),
              buildAddPlayerButton()
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildAmount({Transaction? transaction}) {
    if (transaction != null) {
      amountController.text = transaction.rentAmount.toString();
    }
    return TextFormField(
      controller: amountController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Amount',
      ),
      validator: (name) => name != null && name.isEmpty ? 'Enter Amount' : null,
    );
  }

  Widget buildDate() => TextFormField(
        initialValue: DateFormat.yMMMd().format(DateTime.now()),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildAddMatchButton() => TextButton(
        onPressed: () {
          var amount = double.tryParse(amountController.text) ?? 0;
          final transaction = Transaction()
            ..rentAmount = amount
            ..collectedAmount = 0
            ..dateTime = DateTime.now()
            ..playersPaid = []
            ..playersPlayed = selectedPlayers;
          transactionController.addTransaction(transaction);
          Get.back();
        },
        child: const Text('Add Match'),
      );
  Widget buildUpdateMatchButton(int index, Transaction transactiont) =>
      TextButton(
        onPressed: () {
          var _paidPlayers = transactiont.playersPaid + paidPlayers;
          var count = transactiont.playersPlayed.length;
          var perHeadAmount = (transactiont.rentAmount / count);
          final transaction = Transaction()
            ..rentAmount = transactiont.rentAmount
            ..collectedAmount = paidPlayers.length * perHeadAmount
            ..dateTime = transactiont.dateTime
            ..playersPaid = _paidPlayers.toSet().toList()
            ..playersPlayed = transactiont.playersPlayed;
          transactionController.updateTransactionPayment(
              index: index, transaction: transaction);
          Get.back();
        },
        child: const Text('Update'),
      );

  Widget buildAddPlayerButton() => TextButton(
        onPressed: () {
          final isValid = formKey.currentState!.validate();
          if (isValid) {
            final name = nameController.text;
            final player = Player()..name = name;
            playerController.addPlayer(player);
          }
          Get.back();
          Get.snackbar(
              "Paisa Tracker", '${nameController.text} added to players!');
          nameController.clear();
        },
        child: const Text('Add Player'),
      );
}
