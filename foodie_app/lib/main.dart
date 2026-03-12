import 'package:flutter/material.dart';
import 'package:foodie_app/pages/home.dart';
import 'package:foodie_app/pages/cart.dart';
import 'package:foodie_app/pages/settings.dart';
import 'package:foodie_app/services/theme_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return MaterialApp.router(
      title: 'Foodie',
      routerConfig: _router,
      theme: themeService.themeData,
      debugShowCheckedModeBanner: false,
    );
  }
}
