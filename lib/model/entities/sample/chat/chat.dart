// chat freezed
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qanvas/model/converts/date_time_timestamp_converter.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    String? chatId,
    String? userId,
    String? chat,
    String? name,
    @DateTimeTimestampConverter() DateTime? createdAt,
  }) = _Chat;
  const Chat._();

  factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);
}
