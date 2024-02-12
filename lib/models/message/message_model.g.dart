// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 0;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel(
      messageString: fields[0] as String?,
      chatId: fields[1] as String?,
      media: fields[2] as String?,
      metadata: fields[3] as Metadata?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.messageString)
      ..writeByte(1)
      ..write(obj.chatId)
      ..writeByte(2)
      ..write(obj.media)
      ..writeByte(3)
      ..write(obj.metadata);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetadataAdapter extends TypeAdapter<Metadata> {
  @override
  final int typeId = 1;

  @override
  Metadata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Metadata(
      dateTimeSent: fields[0] as String?,
      toDestinationId: fields[1] as String?,
      fromUserId: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Metadata obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dateTimeSent)
      ..writeByte(1)
      ..write(obj.toDestinationId)
      ..writeByte(2)
      ..write(obj.fromUserId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetadataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
