import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//クラスインポート
import 'package:qanvas/router/bottom_route.dart';
import 'package:qanvas/service/note/screens/folder_screen.dart';
import 'package:qanvas/service/note/screens/note_screen.dart';
import 'package:qanvas/service/search/screens/add_question_note_screen.dart';
import 'package:qanvas/service/search/screens/add_question_screen.dart';

final Router_Provider = Provider(
    (ref) => GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/',
        routes:[
          GoRoute(
              path: '/',
              pageBuilder: (BuildContext context, GoRouterState state) => const MaterialPage(
                  child: BottomRoute()
              ),
            routes: [
              GoRoute(
                  path: 'AddQuestion',
                  pageBuilder: (BuildContext context, GoRouterState state) => const MaterialPage(
                      child: AddQuestionScreen()
                  ),
                  routes: [
                    GoRoute(
                      path: 'AddQuestionNote',
                      pageBuilder: (BuildContext context, GoRouterState state) => const MaterialPage(
                        child: AddQuestionNoteScreen()
                      ),
                    )
                  ]
              ),
              GoRoute(
                path: 'Note/:id',
                pageBuilder: (BuildContext cotext, GoRouterState state){
                 final index = state.params['id'];

                 return MaterialPage(
                   key: state.pageKey,
                   child:  NoteScreen(index: '$index')
                 );
                }
              ),
            ]
          ),
        ]
    ),
);