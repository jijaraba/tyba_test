import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/view/screens/home_view.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/view/screens/login_view.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/view/screens/register_view.dart';
import 'package:tyba_frotend_engineer_test/src/presentation/view/screens/splash_view.dart';

final router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      name: 'splash',
      path: '/',
      pageBuilder: (_, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const SplashView(),
      ),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      pageBuilder: (_, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const LoginView(),
      ),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      pageBuilder: (_, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const RegisterView(),
      ),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      pageBuilder: (_, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const HomeView(),
      ),
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage<void>(
    key: state.pageKey,
    child: Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            state.error?.toString() ?? 'Page no found',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  ),
);
