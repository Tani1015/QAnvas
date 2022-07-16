// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$$_ChatFromJson(Map<String, dynamic> json) => _$_Chat(
      chatId: json['chatId'] as String?,
      userId:
          (json['userId'] as List<dynamic>?)?.map((e) => e as String).toList(),
      chat: json['chat'] as String?,
      name: json['name'] as String?,
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'chatId': instance.chatId,
      'userId': instance.userId,
      'chat': instance.chat,
      'name': instance.name,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
    };
