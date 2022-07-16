//chat provider

import 'package:qanvas/exceptions/app_exception.dart';
import 'package:qanvas/extensions/exception_extension.dart';
import 'package:qanvas/model/entities/sample/room_chat/room_chat.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_atuh_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/entities/sample/chat/chat.dart';
import 'package:qanvas/model/repositories/firebase_storage/firebase_storage_repository.dart';
import 'package:qanvas/model/repositories/firestore/collection_paging_repository.dart';
import 'package:qanvas/model/repositories/firestore/document.dart';
import 'package:qanvas/model/repositories/firestore/document_repository.dart';
import 'package:qanvas/results/result_void_data.dart';
import 'package:qanvas/utils/provider.dart';

final roomChatProvider = StateNotifierProvider<RoomChatController, List<RoomChat>>((ref){
  ref.watch(authStateProvider);
  return RoomChatController(ref.read);
});

class RoomChatController extends StateNotifier<List<RoomChat>> {
 RoomChatController(this._read,) : super([]) {
   _collectionPagingRepository = _read(
     roomChatPagingProvider(
       CollectionParam<RoomChat>(
         query: Document.colRef(
           RoomChat.collectionPath,
         ),
         decode: RoomChat.fromJson,
       ),
     ),
   );
 }

 final Reader _read;

 FirebaseAuthRepository get _firebaseAuthRepository =>
     _read(firebaseAuthRepositoryProvider);

 DocumentRepository get _documentRepository => _read(documentRepositoryProvider);

 CollectionPagingRepository<RoomChat>? _collectionPagingRepository;

 FirebaseStorageRepository get _firebaseStorageRepository =>
     _read(firebaseStorageRepositoryProvider);

 Future<ResultVoidData> fetch() async{
   try{
     final repository = _collectionPagingRepository;
     if(repository == null){
       throw AppException.irregular();
     }
     //entityをステートに入れる
     final data = await repository.fetch(
       fromCache: (cache){
         state = cache.map((e) => e.entity).whereType<Chat>().toList();
       },
     );
     state = data.map((e) => e.entity).whereType<Chat>().toList();
     return const ResultVoidData.success();
     //エラー処理
   } on AppException catch (e) {
     return ResultVoidData.failure(e);
     //エラー表示
   } on Exception catch (e) {
     return ResultVoidData.failure(AppException.error(e.errorMessage));
   }
 }

 Future<ResultVoidData> create(String chat, List<String> userList) async {
   try{
     final userId = _firebaseAuthRepository.loggedInUserId;
     if(userId == null){
       throw AppException(title: 'ログインしてください');
     }
     final ref = Document.docRef(Chat.collectionPath(userId));
     //Firestoreへの保存
     final data = Chat(
       chatId: ref.id,
       chat: chat,
       userId: userList,
     );

     await _documentRepository.save(
       Chat.docPath(userId, ref.id),
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
}