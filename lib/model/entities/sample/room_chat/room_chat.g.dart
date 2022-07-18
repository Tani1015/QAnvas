// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoomChat _$$_RoomChatFromJson(Map<String, dynamic> json) => _$_RoomChat(
      roomId: json['roomId'] as String?,
      roomName: json['roomName'] as String?,
      userId:
          (json['userId'] as List<dynamic>?)?.map((e) => e as String).toList(),
      questionList: (json['questionList'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      chatList: (json['chatList'] as List<dynamic>?)
          ?.map((e) => Chat.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$_RoomChatToJson(_$_RoomChat instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'userId': instance.userId,
      'questionList': instance.questionList,
      'chatList': instance.chatList,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
    };
