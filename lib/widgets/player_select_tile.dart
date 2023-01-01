import 'package:flutter/material.dart';
import 'package:paisa_tracker/controller/transaction_controller.dart';
import 'package:paisa_tracker/model/player.dart';

class PlayerSelectTile extends StatefulWidget {
  final Player player;
  Function(bool) isSelected;
  bool? isChecked;
  PlayerSelectTile({required this.player, required this.isSelected,this.isChecked});

  @override
  State<PlayerSelectTile> createState() => _PlayerSelectTileState();
}

class _PlayerSelectTileState extends State<PlayerSelectTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.player.name),
      trailing: Checkbox(
          value: widget.isChecked,
          onChanged: (bool? value) {
            setState(() {
              widget.isChecked = value;
            });
            widget.isSelected(widget.isChecked!);
          }),
    );
  }
}
