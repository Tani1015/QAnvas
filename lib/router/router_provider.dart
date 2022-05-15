import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//クラスインポート
import 'package:qanvas/router/bottom_route.dart';
import 'package:qanvas/service/search/screens/question_add_screen.dart';
import 'package:qanvas/service/search/screens/add_tag_screen.dart';

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
                  path: 'QuestionAdd',
                  pageBuilder: (BuildContext context, GoRouterState state) => const MaterialPage(
                      child: QuestionAddScreen()
                  ),
                  routes: [
                    GoRoute(
                        path: 'AddTag',
                        pageBuilder: (BuildContext context, GoRouterState state) => const MaterialPage(
                            child: FilterPage()
                        )
                    ),
                  ]
              ),
            ]
          ),
        ]
    ),
);