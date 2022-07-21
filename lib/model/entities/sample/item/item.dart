// item freezed
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/converts/date_time_timestamp_converter.dart';
import 'package:qanvas/model/entities/sample/comment/comment.dart';
import 'package:qanvas/model/entities/storage_file/storage_file.dart';
import 'package:qanvas/model/repositories/firestore/collection_paging_repository.dart';
import 'package:qanvas/model/repositories/firestore/document.dart';

part 'item.freezed.dart';
part 'item.g.dart';

final itemPagingProvider = Provider.family
    .autoDispose<CollectionPagingRepository<Item>, CollectionParam<Item>>(
    (ref, query) {
      return CollectionPagingRepository<Item>(
          query: query.query,
          decode: query.decode
      );
    }
);

@freezed
class Item with _$Item {
  @JsonSerializable(explicitToJson: true)
  const factory Item({
    String? userId,
    String? itemId,
    String? title,
    String? question,
    String? category,
    @DateTimeTimestampConverter() DateTime? createdAt,
    StorageFile? imageUrl,
    List<Comment>? comment,
  }) = _Item;
  const Item._();

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  static String collectionPath() =>
      'QAnvas/v1/items';

  static CollectionReference<SnapType> colRef() =>
      Document.colRef(collectionPath());

  static String docPath(String id) =>
      '${collectionPath()}/$id';
  static DocumentReference<SnapType> docRef(String id) =>
      Document.docRefWithDocPath(docPath(id));

  static String imagePath(
    String userId,
    String id,
    String filename
  ) => '${docPath(id)}/image/$filename';

  Map<String, dynamic> get toCreateDoc => <String, dynamic> {
    'userId' : userId,
    'itemId' : itemId,
    'title' : title,
    'question' : question,
    'category' : category,
    'createdAt' :createdAt ?? FieldValue.serverTimestamp(),
    'imageUrl' : imageUrl?.toJson(),
    'comment' : comment,
  };

  //no image
  Map<String,dynamic> get toDocWithNotImage {
    final data = <String, dynamic> {
      ...toJson(),
      'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
    }..remove('imageUrl');
    return data;
  }

  Map<String, dynamic> get toDocWithComment {
    final data = <String, dynamic> {
      ...toJson(),
      'createdAt' : createdAt ?? FieldValue.serverTimestamp(),
    }..remove('userId')..remove('itemId')..remove('title')..remove('question')..remove('category')..remove('imageUrl');
    return data;
  }
}