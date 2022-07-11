import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_atuh_repository.dart';
import 'package:qanvas/model/repositories/firebase_auth/login_type.dart';



final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

enum AuthState {
  noSignIn,
  signIn
}

final authStateProvider = StateProvider<AuthState>((ref){
  final repository = ref.read(firebaseAuthRepositoryProvider);
  final loginType = repository.loginType;
  final user = repository.authUser;

  switch (loginType) {
    case null:
      return AuthState.noSignIn;
    case LoginType.email:
      return user?.emailVerified == true
          ? AuthState.signIn
          : AuthState.noSignIn;
  }
});