// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      userId: json['userId'] as String?,
      comment: json['comment'] as String?,
      comImageurl: json['comImageurl'] == null
          ? null
          : StorageFile.fromJson(json['comImageurl'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'comment': instance.comment,
      'comImageurl': instance.comImageurl,
    };
