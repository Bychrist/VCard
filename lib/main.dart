import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcard_project/pages/home_page.dart';
import 'package:vcard_project/pages/scan_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Vcard Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
    );
  }

  final _router =
      GoRouter(debugLogDiagnostics: true, initialLocation: '/', routes: [
    GoRoute(
        path: '/',
        name: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: ScanPage.routeName,
            name: ScanPage.routeName,
            builder: (context, state) => const ScanPage(),
          )
        ]),
  ]);
}
