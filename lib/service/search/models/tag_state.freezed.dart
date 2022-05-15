// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TagState _$TagStateFromJson(Map<String, dynamic> json) {
  return _TagState.fromJson(json);
}

/// @nodoc
mixin _$TagState {
  List<TagModel> get tagList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagStateCopyWith<TagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagStateCopyWith<$Res> {
  factory $TagStateCopyWith(TagState value, $Res Function(TagState) then) =
      _$TagStateCopyWithImpl<$Res>;
  $Res call({List<TagModel> tagList});
}

/// @nodoc
class _$TagStateCopyWithImpl<$Res> implements $TagStateCopyWith<$Res> {
  _$TagStateCopyWithImpl(this._value, this._then);

  final TagState _value;
  // ignore: unused_field
  final $Res Function(TagState) _then;

  @override
  $Res call({
    Object? tagList = freezed,
  }) {
    return _then(_value.copyWith(
      tagList: tagList == freezed
          ? _value.tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
    ));
  }
}

/// @nodoc
abstract class _$TagStateCopyWith<$Res> implements $TagStateCopyWith<$Res> {
  factory _$TagStateCopyWith(_TagState value, $Res Function(_TagState) then) =
      __$TagStateCopyWithImpl<$Res>;
  @override
  $Res call({List<TagModel> tagList});
}

/// @nodoc
class __$TagStateCopyWithImpl<$Res> extends _$TagStateCopyWithImpl<$Res>
    implements _$TagStateCopyWith<$Res> {
  __$TagStateCopyWithImpl(_TagState _value, $Res Function(_TagState) _then)
      : super(_value, (v) => _then(v as _TagState));

  @override
  _TagState get _value => super._value as _TagState;

  @override
  $Res call({
    Object? tagList = freezed,
  }) {
    return _then(_TagState(
      tagList: tagList == freezed
          ? _value.tagList
          : tagList // ignore: cast_nullable_to_non_nullable
              as List<TagModel>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_TagState with DiagnosticableTreeMixin implements _TagState {
  const _$_TagState({final List<TagModel> tagList = const <TagModel>[]})
      : _tagList = tagList;

  factory _$_TagState.fromJson(Map<String, dynamic> json) =>
      _$$_TagStateFromJson(json);

  final List<TagModel> _tagList;
  @override
  @JsonKey()
  List<TagModel> get tagList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagList);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagState(tagList: $tagList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagState'))
      ..add(DiagnosticsProperty('tagList', tagList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TagState &&
            const DeepCollectionEquality().equals(other.tagList, tagList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(tagList));

  @JsonKey(ignore: true)
  @override
  _$TagStateCopyWith<_TagState> get copyWith =>
      __$TagStateCopyWithImpl<_TagState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TagStateToJson(this);
  }
}

abstract class _TagState implements TagState {
  const factory _TagState({final List<TagModel> tagList}) = _$_TagState;

  factory _TagState.fromJson(Map<String, dynamic> json) = _$_TagState.fromJson;

  @override
  List<TagModel> get tagList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TagStateCopyWith<_TagState> get copyWith =>
      throw _privateConstructorUsedError;
}
