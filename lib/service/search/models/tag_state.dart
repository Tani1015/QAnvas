import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//クラスインポート
import 'tag_model.dart';

part 'tag_state.freezed.dart';
part 'tag_state.g.dart';

@freezed
abstract class TagState with _$TagState {
  @JsonSerializable(explicitToJson: true)
  const factory TagState({
    @Default(<TagModel>[]) List<TagModel> tagList,
  }) = _TagState;

  factory TagState.fromJson(Map<String, dynamic> json) =>
      _$TagStateFromJson(json);
}