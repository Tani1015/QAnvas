// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TagState _$$_TagStateFromJson(Map<String, dynamic> json) => _$_TagState(
      tagList: (json['tagList'] as List<dynamic>?)
              ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TagModel>[],
    );

Map<String, dynamic> _$$_TagStateToJson(_$_TagState instance) =>
    <String, dynamic>{
      'tagList': instance.tagList.map((e) => e.toJson()).toList(),
    };
