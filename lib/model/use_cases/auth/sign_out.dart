import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_atuh_repository.dart';

//クラスインポート
import 'package:qanvas/utils/provider.dart';

final signOutProvider = Provider((ref) => SignOut(ref.read));

class SignOut{
  SignOut(this._read);
  final Reader _read;

  Future call() async{
    //サインイン状態確認
    _read(authStateProvider.state).update((state) => AuthState.noSignIn);
    await _read(firebaseAuthRepositoryProvider).signOut();
  }
}