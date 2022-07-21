// comment freezed
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qanvas/model/entities/storage_file/storage_file.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';


@freezed
class Comment with _$Comment {
  @JsonSerializable(explicitToJson: true)
  const factory Comment({
    String? userId,
    String? comment,
    StorageFile? comImageurl
  }) = _Comment;
  const Comment._();

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}