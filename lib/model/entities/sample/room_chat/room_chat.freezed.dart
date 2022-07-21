// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'room_chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RoomChat _$RoomChatFromJson(Map<String, dynamic> json) {
  return _RoomChat.fromJson(json);
}

/// @nodoc
mixin _$RoomChat {
  String? get roomId => throw _privateConstructorUsedError;
  String? get roomName => throw _privateConstructorUsedError;
  List<String>? get userId => throw _privateConstructorUsedError;
  List<Question>? get questionList => throw _privateConstructorUsedError;
  List<Chat>? get chatList => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomChatCopyWith<RoomChat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomChatCopyWith<$Res> {
  factory $RoomChatCopyWith(RoomChat value, $Res Function(RoomChat) then) =
      _$RoomChatCopyWithImpl<$Res>;
  $Res call(
      {String? roomId,
      String? roomName,
      List<String>? userId,
      List<Question>? questionList,
      List<Chat>? chatList,
      @DateTimeTimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$RoomChatCopyWithImpl<$Res> implements $RoomChatCopyWith<$Res> {
  _$RoomChatCopyWithImpl(this._value, this._then);

  final RoomChat _value;
  // ignore: unused_field
  final $Res Function(RoomChat) _then;

  @override
  $Res call({
    Object? roomId = freezed,
    Object? roomName = freezed,
    Object? userId = freezed,
    Object? questionList = freezed,
    Object? chatList = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      questionList: questionList == freezed
          ? _value.questionList
          : questionList // ignore: cast_nullable_to_non_nullable
              as List<Question>?,
      chatList: chatList == freezed
          ? _value.chatList
          : chatList // ignore: cast_nullable_to_non_nullable
              as List<Chat>?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_RoomChatCopyWith<$Res> implements $RoomChatCopyWith<$Res> {
  factory _$$_RoomChatCopyWith(
          _$_RoomChat value, $Res Function(_$_RoomChat) then) =
      __$$_RoomChatCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? roomId,
      String? roomName,
      List<String>? userId,
      List<Question>? questionList,
      List<Chat>? chatList,
      @DateTimeTimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$_RoomChatCopyWithImpl<$Res> extends _$RoomChatCopyWithImpl<$Res>
    implements _$$_RoomChatCopyWith<$Res> {
  __$$_RoomChatCopyWithImpl(
      _$_RoomChat _value, $Res Function(_$_RoomChat) _then)
      : super(_value, (v) => _then(v as _$_RoomChat));

  @override
  _$_RoomChat get _value => super._value as _$_RoomChat;

  @override
  $Res call({
    Object? roomId = freezed,
    Object? roomName = freezed,
    Object? userId = freezed,
    Object? questionList = freezed,
    Object? chatList = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_RoomChat(
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value._userId
          : userId // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      questionList: questionList == freezed
          ? _value._questionList
          : questionList // ignore: cast_nullable_to_non_nullable
              as List<Question>?,
      chatList: chatList == freezed
          ? _value._chatList
          : chatList // ignore: cast_nullable_to_non_nullable
              as List<Chat>?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_RoomChat extends _RoomChat with DiagnosticableTreeMixin {
  const _$_RoomChat(
      {this.roomId,
      this.roomName,
      final List<String>? userId,
      final List<Question>? questionList,
      final List<Chat>? chatList,
      @DateTimeTimestampConverter() this.createdAt})
      : _userId = userId,
        _questionList = questionList,
        _chatList = chatList,
        super._();

  factory _$_RoomChat.fromJson(Map<String, dynamic> json) =>
      _$$_RoomChatFromJson(json);

  @override
  final String? roomId;
  @override
  final String? roomName;
  final List<String>? _userId;
  @override
  List<String>? get userId {
    final value = _userId;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Question>? _questionList;
  @override
  List<Question>? get questionList {
    final value = _questionList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Chat>? _chatList;
  @override
  List<Chat>? get chatList {
    final value = _chatList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @DateTimeTimestampConverter()
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RoomChat(roomId: $roomId, roomName: $roomName, userId: $userId, questionList: $questionList, chatList: $chatList, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoomChat'))
      ..add(DiagnosticsProperty('roomId', roomId))
      ..add(DiagnosticsProperty('roomName', roomName))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('questionList', questionList))
      ..add(DiagnosticsProperty('chatList', chatList))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RoomChat &&
            const DeepCollectionEquality().equals(other.roomId, roomId) &&
            const DeepCollectionEquality().equals(other.roomName, roomName) &&
            const DeepCollectionEquality().equals(other._userId, _userId) &&
            const DeepCollectionEquality()
                .equals(other._questionList, _questionList) &&
            const DeepCollectionEquality().equals(other._chatList, _chatList) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(roomId),
      const DeepCollectionEquality().hash(roomName),
      const DeepCollectionEquality().hash(_userId),
      const DeepCollectionEquality().hash(_questionList),
      const DeepCollectionEquality().hash(_chatList),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_RoomChatCopyWith<_$_RoomChat> get copyWith =>
      __$$_RoomChatCopyWithImpl<_$_RoomChat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoomChatToJson(this);
  }
}

abstract class _RoomChat extends RoomChat {
  const factory _RoomChat(
      {final String? roomId,
      final String? roomName,
      final List<String>? userId,
      final List<Question>? questionList,
      final List<Chat>? chatList,
      @DateTimeTimestampConverter() final DateTime? createdAt}) = _$_RoomChat;
  const _RoomChat._() : super._();

  factory _RoomChat.fromJson(Map<String, dynamic> json) = _$_RoomChat.fromJson;

  @override
  String? get roomId => throw _privateConstructorUsedError;
  @override
  String? get roomName => throw _privateConstructorUsedError;
  @override
  List<String>? get userId => throw _privateConstructorUsedError;
  @override
  List<Question>? get questionList => throw _privateConstructorUsedError;
  @override
  List<Chat>? get chatList => throw _privateConstructorUsedError;
  @override
  @DateTimeTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_RoomChatCopyWith<_$_RoomChat> get copyWith =>
      throw _privateConstructorUsedError;
}
