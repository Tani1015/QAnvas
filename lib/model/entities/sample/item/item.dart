// item freezed
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qanvas/model/converts/date_time_timestamp_converter.dart';
import 'package:qanvas/model/entities/sample/comment/comment.dart';
import 'package:qanvas/model/entities/storage_file/storage_file.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  const factory Item({
    String? itemId,
    String? title,
    String? question,
    String? category,
    @DateTimeTimestampConverter() DateTime? createdAt,
    StorageFile? imageUrl,
    Comment? comment,
  }) = _Item;
  const Item._();

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);
}