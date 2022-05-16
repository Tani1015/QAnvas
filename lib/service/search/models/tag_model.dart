import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

@freezed
abstract class TagModel with _$TagModel {
  @JsonSerializable(explicitToJson: true)
  const factory TagModel({
    @Default("") String id,
    @Default("") String title,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String,dynamic> json)
    => _$TagModelFromJson(json);
}