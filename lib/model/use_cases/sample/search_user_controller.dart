


import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/exceptions/app_exception.dart';
import 'package:qanvas/extensions/exception_extension.dart';
import 'package:qanvas/model/entities/sample/user/user.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:qanvas/model/repositories/firebase_storage/firebase_storage_repository.dart';
import 'package:qanvas/model/repositories/firestore/collection_paging_repository.dart';
import 'package:qanvas/model/repositories/firestore/document.dart';
import 'package:qanvas/model/repositories/firestore/document_repository.dart';
import 'package:qanvas/results/result_void_data.dart';

final searchUserTextEditingController = StateProvider.autoDispose((ref){
  return TextEditingController(text: '');
});


final searchUserProvider = StateNotifierProvider<SearchUserController, List<User>>((ref) {
  ref.read(searchUserTextEditingController);
  return SearchUserController(ref.read);
});

class SearchUserController extends StateNotifier<List<User>> {
  SearchUserController(this._read,) : super([]);

  final Reader _read;

  CollectionPagingRepository<User>? _collectionPagingRepository;

  Future<ResultVoidData> search(String name) async {
    try {
      _collectionPagingRepository = _read(
        userPagingProvider(
          CollectionParam<User>(
            query: Document.colRef(
                User.collectionPath
            ).where('name', isEqualTo: name),
            decode: User.fromJson,
          ),
        ),
      );

      final repository = _collectionPagingRepository;
      if (repository == null) {
        throw AppException.irregular();
      }
      //entityをステートに入れる
      final data = await repository.fetch(
        fromCache: (cache) {
          state = cache.map((e) => e.entity).whereType<User>().toList();
        },
      );
      state = data.map((e) => e.entity).whereType<User>().toList();
      return const ResultVoidData.success();
      //エラー処理
    } on AppException catch (e) {
      return ResultVoidData.failure(e);
      //エラー表示
    } on Exception catch (e) {
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }
}