// chat freezed
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/converts/date_time_timestamp_converter.dart';
import 'package:qanvas/model/repositories/firestore/collection_paging_repository.dart';
import 'package:qanvas/model/repositories/firestore/document.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    String? chatId, //ref.id
    List<String>? userId, //userList
    String? chat, //chat
    String? name, //user_name
    @DateTimeTimestampConverter() DateTime? createdAt,
  }) = _Chat;
  const Chat._();

  factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);
}
