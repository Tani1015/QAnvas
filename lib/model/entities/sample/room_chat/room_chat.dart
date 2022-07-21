import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/converts/date_time_timestamp_converter.dart';
import 'package:qanvas/model/entities/sample/chat/chat.dart';
import 'package:qanvas/model/entities/sample/question/question.dart';
import 'package:qanvas/model/repositories/firestore/collection_paging_repository.dart';
import 'package:qanvas/model/repositories/firestore/document.dart';

part 'room_chat.freezed.dart';
part 'room_chat.g.dart';

final roomChatPagingProvider = Provider.family
    .autoDispose<CollectionPagingRepository<RoomChat>, CollectionParam<RoomChat>>(
        (ref, query) {
          return CollectionPagingRepository<RoomChat>(
            query: query.query,
            decode: query.decode
          );
        }
);

@freezed
class RoomChat with _$RoomChat {
  @JsonSerializable(explicitToJson: true)
  const factory RoomChat({
    String? roomId,
    String? roomName,
    List<String>? userId,
    List<Question>? questionList,
    List<Chat>? chatList,
    @DateTimeTimestampConverter() DateTime? createdAt,
  }) = _RoomChat;
  const RoomChat._();

  factory RoomChat.fromJson(Map<String, dynamic> json) =>
      _$RoomChatFromJson(json);

  static String get collectionPath =>
      'QAnvas/v1/rooms';
  static CollectionReference<SnapType> colRef() =>
    Document.colRef(collectionPath);

  static String docPath(String id) => '$collectionPath/$id';
  static DocumentReference<SnapType> docRef(String id) =>
      Document.docRefWithDocPath(docPath(id));

  Map<String, dynamic> get toCreateDoc => <String, dynamic> {
    'roomId' : roomId,
    'roomName' : roomName,
    'userId' : userId,
    'questionList' : questionList,
    'chatList' : chatList,
    'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
  };

  Map<String, dynamic> get toDocWithNotQuestion {
    final data = <String, dynamic> {
      ...toJson(),
      'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
    }..remove('roomId')..remove('roomName')..remove('userId')..remove('questionList');
    return data;
  }

  Map<String, dynamic> get toDocRoom {
    final data = <String, dynamic> {
      ...toJson(),
      'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
    }..remove('chatList')..remove('questionList');
    return data;
  }

  Map<String, dynamic> get toDocWithNotChat {
    final data = <String, dynamic> {
      ...toJson(),
      'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
    }..remove('roomId')..remove('roomName')..remove('userId')..remove('chatList');
    return data;
  }

  Map<String, dynamic> get toDocWithUser {
    final data = <String, dynamic> {
      ...toJson(),
      'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
    }..remove('roomId')..remove('roomName')..remove('questionList')..remove('chatList');
    return data;
  }

}