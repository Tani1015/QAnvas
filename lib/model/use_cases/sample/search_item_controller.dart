//item provider
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/exceptions/app_exception.dart';
import 'package:qanvas/extensions/exception_extension.dart';
import 'package:qanvas/model/entities/sample/comment/comment.dart';
import 'package:qanvas/model/entities/sample/item/item.dart';
import 'package:qanvas/model/entities/storage_file/storage_file.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:qanvas/model/repositories/firebase_storage/firebase_storage_repository.dart';
import 'package:qanvas/model/repositories/firebase_storage/mime_type.dart';
import 'package:qanvas/model/repositories/firestore/collection_paging_repository.dart';
import 'package:qanvas/model/repositories/firestore/document.dart';
import 'package:qanvas/model/repositories/firestore/document_repository.dart';
import 'package:qanvas/results/result_void_data.dart';
import 'package:qanvas/utils/provider.dart';
import 'package:qanvas/utils/uuid_generator.dart';

final searchTextEditingController = StateProvider.autoDispose((ref){
  return TextEditingController(text: '');
});


final searchItemProvider = StateNotifierProvider<SearchItemController, List<Item>>((ref) {
  ref.read(searchTextEditingController);
  return SearchItemController(ref.read);
});

class SearchItemController extends StateNotifier<List<Item>> {
  SearchItemController(this._read,) : super([]) {
    final userId = _firebaseAuthRepository.loggedInUserId;
    if (userId == null) {
      return;
    }

    final searchText = _searchText.text;

    _collectionPagingRepository = _read(
      itemPagingProvider(
        CollectionParam<Item>(
          query: Document.colRef(
            Item.collectionPath(),
          ).where('category', isEqualTo: searchText)
              .orderBy('createdAt',descending: true),
          decode: Item.fromJson,
        ),
      ),
    );
  }

  final Reader _read;

  TextEditingController get _searchText =>
      _read(searchTextEditingController);

  FirebaseAuthRepository get _firebaseAuthRepository =>
      _read(firebaseAuthRepositoryProvider);

  DocumentRepository get _documentRepository => _read(documentRepositoryProvider);

  CollectionPagingRepository<Item>? _collectionPagingRepository;

  FirebaseStorageRepository get _firebaseStorageRepository =>
      _read(firebaseStorageRepositoryProvider);

  Future<ResultVoidData> fetch(String category) async{
    try{
      _collectionPagingRepository = _read(
        itemPagingProvider(
          CollectionParam<Item>(
            query: Document.colRef(
              Item.collectionPath(),
            ).where('category', isEqualTo: category)
                .orderBy('createdAt',descending: true),
            decode: Item.fromJson,
          ),
        ),
      );

      final repository = _collectionPagingRepository;
      if(repository == null){
        throw AppException.irregular();
      }
      //entityをステートに入れる
      final data = await repository.fetch(
        fromCache: (cache){
          state = cache.map((e) => e.entity).whereType<Item>().toList();
        },
      );
      state = data.map((e) => e.entity).whereType<Item>().toList();
      return const ResultVoidData.success();
      //エラー処理
    } on AppException catch (e) {
      return ResultVoidData.failure(e);
      //エラー表示
    } on Exception catch (e) {
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  Future<ResultVoidData> create(String title,String question, String category,Uint8List file) async {
    try{
      final userId = _firebaseAuthRepository.loggedInUserId;
      if(userId == null){
        throw AppException(title: 'ログインしてください');
      }
      final ref = Document.docRef(Item.collectionPath());
      final now = DateTime.now();

      //画像の保存(cloud storage)
      final filename = UuidGenerator.create();
      final imagePath = Item.imagePath(userId, ref.id, filename);
      const mimeType = MimeType.applicationOctetStream;
      final imageUrl = await _read(firebaseStorageRepositoryProvider).save(
        file,
        path: imagePath,
        mimeType: mimeType,
      );
      //Firestoreへの保存
      final data = Item(
          userId: userId,
          itemId: ref.id,
          title: title,
          question: question,
          category: category,
          imageUrl: StorageFile(
            url: imageUrl,
            path: imagePath,
            mimeType: mimeType.value,
          ),
          createdAt: now
      );

      await _documentRepository.save(
        Item.docPath(ref.id),
        data: data.toCreateDoc,
      );

      //state変更
      state = [data, ...state];
      return const ResultVoidData.success();
    }on AppException catch(e) {
      return ResultVoidData.failure(e);
    }on Exception catch (e) {
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  Future<ResultVoidData> createWithNoteImage(String title,String question, String category) async {
    try{
      final userId = _firebaseAuthRepository.loggedInUserId;
      if(userId == null){
        throw AppException(title: 'ログインしてください');
      }
      final ref = Document.docRef(Item.collectionPath());
      final now = DateTime.now();


      //Firestoreへの保存
      final data = Item(
          userId: userId,
          itemId: ref.id,
          title: title,
          question: question,
          category: category,
          createdAt: now
      );

      await _documentRepository.save(
        Item.docPath(ref.id),
        data: data.toCreateDoc,
      );

      //state変更
      state = [data, ...state];
      return const ResultVoidData.success();
    }on AppException catch(e) {
      return ResultVoidData.failure(e);
    }on Exception catch (e) {
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  Future<ResultVoidData> updateComment(Item item,List<Comment>? comment) async {
    try{
      final now = DateTime.now();
      //Firestoreへの保存
      final data = item.copyWith(
          comment: comment,
          createdAt: now
      );
      await _documentRepository.save(
        Item.docPath(item.itemId!),
        data: data.toDocWithComment,
      );
      //state変更
      state = [data, ...state];
      return const ResultVoidData.success();
    }on AppException catch(e) {
      return ResultVoidData.failure(e);
    }on Exception catch (e) {
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

}