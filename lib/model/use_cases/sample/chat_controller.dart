//chat provider

import 'package:qanvas/exceptions/app_exception.dart';
import 'package:qanvas/extensions/exception_extension.dart';
import 'package:qanvas/model/entities/sample/question/question.dart';
import 'package:qanvas/model/entities/sample/room_chat/room_chat.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_auth_repository.dart';
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
   final userId = _firebaseAuthRepository.loggedInUserId;
   if (userId == null) {
     return;
   }
   _collectionPagingRepository = _read(
     roomChatPagingProvider(
       CollectionParam<RoomChat>(
         query: Document.colRef(
           RoomChat.collectionPath,
         ).where('userId', arrayContains: userId).orderBy('createdAt'),
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
     //entity???????????????????????????
     final data = await repository.fetch(
       fromCache: (cache){
         state = cache.map((e) => e.entity).whereType<RoomChat>().toList();
       },
     );
     state = data.map((e) => e.entity).whereType<RoomChat>().toList();
     return const ResultVoidData.success();
     //???????????????
   } on AppException catch (e) {
     return ResultVoidData.failure(e);
     //???????????????
   } on Exception catch (e) {
     return ResultVoidData.failure(AppException.error(e.errorMessage));
   }
 }

 Future<ResultVoidData> create(String roomName, List<String> usersId) async {
   try{
     final userId = _firebaseAuthRepository.loggedInUserId;
     if(userId == null){
       throw AppException(title: '??????????????????????????????');
     }
     final ref = Document.docRef(RoomChat.collectionPath);
     final now = DateTime.now();

     //Firestore????????????
     final data = RoomChat(
       roomId: ref.id,
       roomName: roomName,
       userId: usersId,
       createdAt: now
     );

     await _documentRepository.save(
       RoomChat.docPath(ref.id),
       data: data.toDocRoom,
     );

     //state??????
     state = [data, ...state];
     return const ResultVoidData.success();
   }on AppException catch(e) {
     return ResultVoidData.failure(e);
   }on Exception catch (e) {
     return ResultVoidData.failure(AppException.error(e.errorMessage));
   }
 }

 Future<ResultVoidData> updateQuestion(RoomChat roomChat, String question) async {
   try{
     final userId = _firebaseAuthRepository.loggedInUserId;
     if(userId == null) {
       throw AppException(title: '??????????????????????????????');
     }

     final docId = roomChat.roomId;
     if (docId == null) {
       throw AppException.irregular();
     }

     final ref = Document.docRef(RoomChat.collectionPath);
     final now = DateTime.now();
     final name = _firebaseAuthRepository.authUser?.displayName;

     Question newQuestion = Question(
       questionId: ref.id,
       userId: userId,
       question: question,
       name: name,
       comment: null,
       createdAt: now
     );

     final List<Question>? newQuestionList = roomChat.questionList;
     newQuestionList?.add(newQuestion);

     final data = roomChat.copyWith(
       questionList: newQuestionList,
       createdAt: roomChat.createdAt
     );

     await _documentRepository.update(
       RoomChat.docPath(ref.id),
       data: data.toDocWithNotChat
     );

     state = state
         .map(
             (e) => e.roomId == roomChat.roomId ? roomChat : e)
         .toList();
     return const ResultVoidData.success();
   } on AppException catch (e) {
     return ResultVoidData.failure(e);
   } on Exception catch (e) {
     return ResultVoidData.failure(AppException.error(e.errorMessage));
   }
 }

 Future<ResultVoidData> updateChat(RoomChat roomChat, List<Chat>? chat) async {
   try{
     final userId = _firebaseAuthRepository.loggedInUserId;
     if(userId == null) {
       throw AppException(title: '??????????????????????????????');
     }

     final docId = roomChat.roomId;
     if (docId == null) {
       throw AppException.irregular();
     }

     final now = DateTime.now();

     final data = roomChat.copyWith(
         chatList: chat,
         createdAt: now
     );

     await _documentRepository.update(
         RoomChat.docPath(roomChat.roomId!),
         data: data.toDocWithNotQuestion
     );

     state = state
         .map(
             (e) => e.roomId == roomChat.roomId ? roomChat : e)
         .toList();
     return const ResultVoidData.success();
   } on AppException catch (e) {
     return ResultVoidData.failure(e);
   } on Exception catch (e) {
     return ResultVoidData.failure(AppException.error(e.errorMessage));
   }
 }

 Future<ResultVoidData> updateUser(RoomChat roomChat, List<String>? userId) async {
   try{

     final docId = roomChat.roomId;
     if (docId == null) {
       throw AppException.irregular();
     }

     final now = DateTime.now();

     final data = roomChat.copyWith(
         userId: userId,
         createdAt: now
     );

     await _documentRepository.update(
         RoomChat.docPath(roomChat.roomId!),
         data: data.toDocWithUser
     );

     state = state
         .map(
             (e) => e.roomId == roomChat.roomId ? roomChat : e)
         .toList();
     return const ResultVoidData.success();
   } on AppException catch (e) {
     return ResultVoidData.failure(e);
   } on Exception catch (e) {
     return ResultVoidData.failure(AppException.error(e.errorMessage));
   }
 }
}