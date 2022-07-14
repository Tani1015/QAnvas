// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Question _$$_QuestionFromJson(Map<String, dynamic> json) => _$_Question(
      questionId: json['questionId'] as String?,
      userId: json['userId'] as String?,
      question: json['question'] as String?,
      name: json['name'] as String?,
      comment: json['comment'] == null
          ? null
          : Comment.fromJson(json['comment'] as Map<String, dynamic>),
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$_QuestionToJson(_$_Question instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'userId': instance.userId,
      'question': instance.question,
      'name': instance.name,
      'comment': instance.comment,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
    };
