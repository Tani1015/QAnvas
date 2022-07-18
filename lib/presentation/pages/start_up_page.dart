import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qanvas/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:qanvas/model/repositories/shared_preferences/shared_preference_key.dart';
import 'package:qanvas/model/repositories/shared_preferences/shared_preference_repository.dart';
import 'package:qanvas/model/use_cases/auth/email/sign_in_with_email_and_password.dart';
import 'package:qanvas/presentation/custom_hooks/use_effect_once.dart';
import 'package:qanvas/presentation/pages/main/main_page.dart';
import 'package:qanvas/presentation/pages/signin_page.dart';
import 'package:qanvas/utils/provider.dart';



class StartUpPage extends HookConsumerWidget {

  const StartUpPage({super.key});

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context,rootNavigator: true)
        .pushReplacement<MaterialPageRoute<dynamic>, void>(
      PageTransition(
        child: const StartUpPage(),
        type:  PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnce((){
      Future(() async {
        //shared preferencesでメールとパスワードの認証をしてログインする
        final localdb = ref.read(sharedPreferencesRepositoryProvider);
        //　※emailとpasswordは暗号化していない
        final String? localEmail = localdb.fetch<String>(SharedPreferencesKey.email);
        final String? localPass = localdb.fetch<String>(SharedPreferencesKey.password);
        if(localEmail != null && localPass != null){
          ref.read(signInWithEmailAndPasswordProvider).call(localEmail, localPass);
        }
        //loginTypeの確認 null or email
        final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
        if(userId != null){
          ref.read(authStateProvider.state).update((state) => AuthState.signIn);
          await MainPage.show(context);
        }else {
          await SigninPage.show(context);
        }
      });
      return null;
    });
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}