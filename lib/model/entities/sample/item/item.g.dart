// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Item _$$_ItemFromJson(Map<String, dynamic> json) => _$_Item(
      itemId: json['itemId'] as String?,
      title: json['title'] as String?,
      question: json['question'] as String?,
      category: json['category'] as String?,
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp?),
      imageUrl: json['imageUrl'] == null
          ? null
          : StorageFile.fromJson(json['imageUrl'] as Map<String, dynamic>),
      comment: (json['comment'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ItemToJson(_$_Item instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'title': instance.title,
      'question': instance.question,
      'category': instance.category,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'imageUrl': instance.imageUrl,
      'comment': instance.comment,
    };
