// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 1;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction()
      ..dateTime = fields[0] as DateTime
      ..rentAmount = fields[1] as double
      ..collectedAmount = fields[2] as double
      ..playersPlayed = (fields[3] as List).cast<Player>()
      ..playersPaid = (fields[4] as List).cast<Player>();
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.rentAmount)
      ..writeByte(2)
      ..write(obj.collectedAmount)
      ..writeByte(3)
      ..write(obj.playersPlayed)
      ..writeByte(4)
      ..write(obj.playersPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
