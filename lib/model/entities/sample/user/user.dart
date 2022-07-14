import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:qanvas/model/entities/storage_file/storage_file.dart';
import 'package:qanvas/model/repositories/firestore/document.dart';


part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String userId,
    String? name,
    StorageFile? image,
  }) = _User;
  const User._();

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  static String get collectionPath => 'angya/v1/users';
  static CollectionReference<SnapType> colRef() =>
      Document.colRef(collectionPath);

  static String docPath(String id) => '$collectionPath/$id';
  static DocumentReference<SnapType> docRef(String id) =>
      Document.docRefWithDocPath(docPath(id));

  static String imagePath(
      String id,
      String filename,
      ) =>
      '${docPath(id)}/image/$filename';

  //'image' not json => data  { return data }
  Map<String, dynamic> get toDocWithNotImage {
    final data = <String, dynamic>{
      ...toJson(),
    }..remove('image');
    return data;
  }

  Map<String, dynamic> get toImageOnly => <String,dynamic>{
    'userId' : userId,
    'image' : image?.toJson()
  };
}