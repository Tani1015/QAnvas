import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import 'mime_type.dart';

final firebaseStorageRepositoryProvider = Provider<FirebaseStorageRepository>(
        (ref) => FirebaseStorageRepository(FirebaseStorage.instance)
);

class FirebaseStorageRepository {
  FirebaseStorageRepository(this._storage);

  final FirebaseStorage _storage;

  PublishSubject<TaskSnapshot>? _uploader;

  Stream<TaskSnapshot> get snapshotsEvents => _uploader!.stream;
  // metadata: view image on console
  Future<String> save(
      Uint8List data,{
        required String path,
        String? cacheControl,
        MimeType? mimeType,
        Map<String, String> metadata = const <String, String>{},
      }) async {
    final ref = _storage.ref(path);
    final uploadTask = ref.putData(
      data,
      SettableMetadata(
          cacheControl: cacheControl,
          contentType: mimeType?.value,
          customMetadata: metadata
      ),
    );
    if(_uploader != null){
      uploadTask.snapshotEvents.listen(_uploader!.add);
    }
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<FullMetadata> saveWithString(
      String data, {
        required String path,
        PublishSubject<TaskSnapshot>? uploader,
      }) async {
    final ref = _storage.ref(path);
    final uploadTask = ref.putString(data);
    if(uploader != null) {
      uploadTask.snapshotEvents.listen(uploader.add);
    }
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getMetadata();
  }

  Future<String> fetchDownloadUrl(String path) =>
      _storage.ref(path).getDownloadURL();

  Future<Uint8List?> fetchData(String path) => _storage.ref(path).getData();

  Future<void> delete(String path) => _storage.ref().child(path).delete();

  void fetch() {
    _uploader ??= PublishSubject<TaskSnapshot>();
  }

  void dispose() {
    _uploader?.close();
    _uploader = null;
  }
}