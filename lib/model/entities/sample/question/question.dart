// question freezed
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qanvas/model/converts/date_time_timestamp_converter.dart';
import 'package:qanvas/model/entities/sample/comment/comment.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  const factory Question({
    String? questionId,
    List<String>? userId,
    String? question,
    String? name,
    Comment? comment,
    @DateTimeTimestampConverter() DateTime? createdAt,
  }) = _Question;
  const Question._();

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}