


import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_atuh_repository.dart';
import 'package:qanvas/utils/provider.dart';

final createUserWithEmailAndPasswordProvider =
Provider((ref) => CreateUserWithEmailAndPassword(ref.read));

class CreateUserWithEmailAndPassword {
  CreateUserWithEmailAndPassword(this._read);

  final Reader _read;

  Future call(String email, String password) async{
    final repository = _read(firebaseAuthRepositoryProvider);
    final authState = _read(authStateProvider.state);

    await repository.createUserWithEmailAndPassword(email, password);
    authState.update((state) => AuthState.noSignIn);
  }
}