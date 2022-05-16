// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'tag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return _TagModel.fromJson(json);
}

/// @nodoc
mixin _$TagModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagModelCopyWith<TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagModelCopyWith<$Res> {
  factory $TagModelCopyWith(TagModel value, $Res Function(TagModel) then) =
      _$TagModelCopyWithImpl<$Res>;
  $Res call({String id, String title});
}

/// @nodoc
class _$TagModelCopyWithImpl<$Res> implements $TagModelCopyWith<$Res> {
  _$TagModelCopyWithImpl(this._value, this._then);

  final TagModel _value;
  // ignore: unused_field
  final $Res Function(TagModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$TagModelCopyWith<$Res> implements $TagModelCopyWith<$Res> {
  factory _$TagModelCopyWith(_TagModel value, $Res Function(_TagModel) then) =
      __$TagModelCopyWithImpl<$Res>;
  @override
  $Res call({String id, String title});
}

/// @nodoc
class __$TagModelCopyWithImpl<$Res> extends _$TagModelCopyWithImpl<$Res>
    implements _$TagModelCopyWith<$Res> {
  __$TagModelCopyWithImpl(_TagModel _value, $Res Function(_TagModel) _then)
      : super(_value, (v) => _then(v as _TagModel));

  @override
  _TagModel get _value => super._value as _TagModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
  }) {
    return _then(_TagModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_TagModel with DiagnosticableTreeMixin implements _TagModel {
  const _$_TagModel({this.id = "", this.title = ""});

  factory _$_TagModel.fromJson(Map<String, dynamic> json) =>
      _$$_TagModelFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String title;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagModel(id: $id, title: $title)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TagModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title));

  @JsonKey(ignore: true)
  @override
  _$TagModelCopyWith<_TagModel> get copyWith =>
      __$TagModelCopyWithImpl<_TagModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TagModelToJson(this);
  }
}

abstract class _TagModel implements TagModel {
  const factory _TagModel({final String id, final String title}) = _$_TagModel;

  factory _TagModel.fromJson(Map<String, dynamic> json) = _$_TagModel.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TagModelCopyWith<_TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}
